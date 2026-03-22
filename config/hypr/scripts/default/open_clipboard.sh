selection=$(cliphist list | wofi --dmenu)
case "$selection" in
	"") ;;
	clear) cliphist wipe ;;
	*) echo "$selection" | cliphist decode | wl-copy ;;
esac
