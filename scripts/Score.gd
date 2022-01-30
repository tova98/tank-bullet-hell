extends RichTextLabel

func change_score(score):
	bbcode_text = "[right]" + str(int(bbcode_text) + score) + "[/right]"
