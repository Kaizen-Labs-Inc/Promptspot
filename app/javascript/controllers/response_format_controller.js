import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["field"]


    toggle(event) {
        this.fieldTarget.value = event.target.checked ? 'json' : null;
    }
}
