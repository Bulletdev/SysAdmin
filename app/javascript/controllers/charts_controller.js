import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    growthSeries: Array,
    growthLabels: Array,
    roleLabels: Array,
    roleSeries: Array,
    deptLabels: Array,
    deptSeries: Array
  }

  connect() {
    const ChartLib = window.Chart
    if (!ChartLib) {
      console.error('[ChartsController] Chart.js global not available')
      return
    }
    console.log("[ChartsController] connect", {
      growthLabels: this.growthLabelsValue,
      growthSeries: this.growthSeriesValue,
      roleLabels: this.roleLabelsValue,
      roleSeries: this.roleSeriesValue,
      deptLabels: this.deptLabelsValue,
      deptSeries: this.deptSeriesValue,
      ChartAvailable: typeof Chart !== 'undefined'
    })
    // User Growth
    const growthCanvas = this.element.querySelector('#userGrowthChart')
    if (growthCanvas) {
      const ctx = growthCanvas.getContext('2d')
      try {
        new ChartLib(ctx, {
          type: 'line',
          data: {
            labels: this.growthLabelsValue?.length ? this.growthLabelsValue : ['Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov'],
            datasets: [{
              label: 'Novos Usuários',
              data: this.growthSeriesValue?.length ? this.growthSeriesValue : [12, 19, 15, 25, 22, 0],
              borderColor: 'rgb(59, 130, 246)',
              backgroundColor: 'rgba(59, 130, 246, 0.1)',
              tension: 0.4,
              fill: true
            }]
          },
          options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
          }
        })
      } catch (e) {
        console.error('[ChartsController] growth chart error', e)
      }
    }

    // Role Distribution (Job Role)
    const roleCanvas = this.element.querySelector('#roleDistributionChart')
    if (roleCanvas && this.roleSeriesValue?.length) {
      const ctx = roleCanvas.getContext('2d')
      try {
        new ChartLib(ctx, {
          type: 'doughnut',
          data: {
            labels: this.roleLabelsValue,
            datasets: [{
              data: this.roleSeriesValue,
              backgroundColor: [
                'rgb(34, 197, 94)',
                'rgb(251, 191, 36)',
                'rgb(59, 130, 246)',
                'rgb(244, 63, 94)',
                'rgb(99, 102, 241)'
              ],
              borderWidth: 0
            }]
          },
          options: {
            responsive: true,
            plugins: { legend: { position: 'bottom' } }
          }
        })
      } catch (e) {
        console.error('[ChartsController] role chart error', e)
      }
    }

    // Department Distribution
    const deptCanvas = this.element.querySelector('#departmentDistributionChart')
    if (deptCanvas && this.deptSeriesValue?.length) {
      const ctx = deptCanvas.getContext('2d')
      try {
        new ChartLib(ctx, {
          type: 'bar',
          data: {
            labels: this.deptLabelsValue,
            datasets: [{
              label: 'Usuários por Setor',
              data: this.deptSeriesValue,
              backgroundColor: 'rgba(99, 102, 241, 0.6)'
            }]
          },
          options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
          }
        })
      } catch (e) {
        console.error('[ChartsController] department chart error', e)
      }
    }
  }
}