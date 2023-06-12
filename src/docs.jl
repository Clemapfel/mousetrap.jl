const SIGNAL_HEADER = "| Signal ID | Signature | Emitted when... |\n|--|--|--|\n"

struct SignalDescriptor
    id::Symbol
    signature::String
    emitted_when::String
end

const signal_descriptors = Dict{Symbol, SignalDescriptor}()

function add_signal(id::Symbol, signature::String, description::String)
    signal_descriptors[id] = SignalDescriptor(id, signature, description)
end

function signature(args_t, return_t) ::String
    out = "("

    n = length(args_t)
    for i in 1:n
        out *= "::" * string(args_t[i]) * ", "
    end

    out *= "(::Data_t)) -> "
    out *= string(return_t)
end

void_signature = "((::Data_t)) -> Nothing"

add_signal(:activate, void_signature, "widget::activate is called or widget is otherwise activated")
add_signal(:startup,  void_signature, "`Application` is in the process of initializing")
add_signal(:shutdown, void_signature, "`Application` is done initializing and will now start the main render loop")
add_signal(:update, void_signature, "once per frame, at the start of a render loop")
add_signal(:paint, void_signature, "once per frame, right before the associated widget is drawn")
add_signal(:realize, void_signature, "widget is fully initialized and about to be rendered for the first time")
add_signal(:unrealize, void_signature, "widget was hidden and will seize being displayed")
add_signal(:destroy, void_signature, "A widgets ref count reaches 0 and its finalizer is called")
add_signal(:hide, void_signature, "widget::hide is called or a widget becomes no longer visible otherwise")
add_signal(:show, void_signature, "widget is rendered on screen for the first time")
add_signal(:map, void_signature, "widgets size allocation was assigned")
add_signal(:unmap, void_signature, "widget or one of its parents is hidden")
add_signal(:close_request, "((::Data_t)) -> allow_close::WindowCloseRequestResult", "mousetrap or the users operating system requests for a window to close")
add_signal(:close, void_signature, "popover is closed")
add_signal(:activate_default_widget, void_signature, "widget assigned via Window::set_default_widget is activated is activated")
add_signal(:activate_focused_widget, void_signature, "widget that currently holds focus is activated")
add_signal(:clicked, void_signature, "user activates the widget by clicking it with a mouse or touch-device")
add_signal(:toggled, void_signature, "widgets internal state changes")
add_signal(:text_changed, void_signature, "underlying text buffer is modified in any way")
add_signal(:selection_changed, "(position::Integer, n_items::Integer, (::Data_t)) -> Nothing", "quantity or index of selected elements changes")
add_signal(:key_pressed, "(code::KeyCode, modifiers::ModifierState, (::Data_t)) -> should_invoke_default_handlers::Bool", "user pressed a non-modifier key")
add_signal(:key_released, "(code::KeyCode, modifiers::ModifierState, (::Data_t)) -> Nothing", "user releases a non-modifier key")
add_signal(:modifiers_changed, "(code::KeyCode, modifiers::ModifierState, (::Data_t)) -> Nothing", "user presses or releases a modifier key")
add_signal(:drag_begin, "(start_x::AbstractFloat, start_y::AbstractFloat, (::Data_t)) -> Nothing", "first frame at which a drag gesture is recognized")
add_signal(:drag, "(x_offset::AbstractFloat, y_offset::AbstractFloat, (::Data_t)) -> Nothing", "once per frame while a drag gesture is active")
add_signal(:drag_begin, "(x_offset::AbstractFloat, y_offset::AbstractFloat, (::Data_t)) -> Nothing", "drag gesture seizes to be active")
add_signal(:click_pressed, "(n_presses::Integer, x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Nothing", "User presses a mouse button or touch-device")
add_signal(:click_released, "(n_presses::Integer, x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Nothing", "User releases a mouse button or touch-device")
add_signal(:clip_stopped, void_signature, "once when a series of clicks ends")
add_signal(:focus_gained, void_signature, "Widget acquires input focus")
add_signal(:focus_lost, void_signature, "Widget looses input focus")
add_signal(:pressed, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Nothing", "long-press gesture is recognized")
add_signal(:press_cancelled, void_signature, "long-press gesture seizes to be active")
add_signal(:motion_enter, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Nothing", "cursor enters allocated area of the widget for the first time")
add_signal(:motion_enter, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Nothing", "once per frame while cursor is inside allocated area of the widget")
add_signal(:motion_enter, void_signature, "cursor leaves allocated area of the widget")
add_signal(:scale_changed, "(scale::AbstractFloat, (::Data_t)) -> Nothing", "distance between two fingers recognized as a pinch-zoom-gesture changes")
add_signal(:rotation_changed, "(angle_absolute_radians::AbstractFloat, angle_delta_radians::AbstractFloat, (::Data_t)) -> Cvoid", "angle between two fingers recognized as a rotate-gesture changes")
add_signal(:scroll_begin, void_signature, "user initiates a scroll gesture using the mouse scrollwheel or a touch-device")
add_signal(:scroll, "(x_delta::AbstractFloat, y_delta::AbstractFloat, (::Data_t)) -> also_invoke_default_handlers::Bool", "once per frame while scroll gesture is active")
add_signal(:scroll_end, void_signature, "user seizes scrolling")
add_signal(:kinetic_scroll_decelerate, "(x_velocity::AbstractFloat, y_velocity::AbstractFloat, (::Data_t)) -> Cvoid", "widget is still scrolling due to scrolling \"inertia\"")
add_signal(:stylus_down, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Cvoid", "stylus makes physical contact with the touchpad")
add_signal(:stylus_up, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Cvoid", "stylus seizes to make contact with the touchpad")
add_signal(:proximity, "(x::AbstractFloat, y::AbstractFloat, (::Data_t)) -> Cvoid", "stylus enters or leaves maximum distance recognized by the touchpad")
add_signal(:swipe, "(x_velocity::AbstractFloat, y_velocity::AbstractFloat, (::Data_t)) -> Cvoid", "swipe gesture is recognized")
add_signal(:pan, "(::PanDirection, offset::AbstractFloat, (::Data_t)) -> Cvoid", "pan gesture is recognized")
add_signal(:value_changed, void_signature, "`value` property of underlying adjustment changes")
add_signal(:properties_changed, void_signature, "any property other than `value` of underlying adjustment changes")
add_signal(:wrapped, void_signature, "`SpinButton` for whom `is_wrapped` is enabled has its value increased or decreased past the given range")
add_signal(:scroll_child, "(::ScrollType, is_horizontal::Bool, (::Data_t)) -> Cvoid", "user triggers a scroll action")
add_signal(:resize, "(width::Integer, height::Integer, (::Data_t)) -> void", "allocated size of `RenderArea` changes while it is realized")
add_signal(:activated, void_signature, "`Action` is activated")
add_signal(:revealed, void_signature, "child is fully revealed (after the animation has finished)")
add_signal(:page_reordered, "(page_index::Integer, (::Data_t)) -> Cvoid", "page of `Notebook` changes position")
add_signal(:page_added, "(page_index::Integer, (::Data_t)) -> Cvoid", "number of pages increases while the widget is realized")
add_signal(:page_reordered, "(page_index::Integer, (::Data_t)) -> Cvoid", "number of pages decreases while the widget is realized")
add_signal(:page_reordered, "(page_index::Integer, (::Data_t)) -> Cvoid", "currently visible page changes")
add_signal(:items_changed, "(position::Integer, n_removed::Integer, n_added::Integet, (::Data_t)) -> Cvoid", "list of items is modified")


for signal in signal_descriptors
    println(signal[2].id, " : \t", signal[2].signature)
end
