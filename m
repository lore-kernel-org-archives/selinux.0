From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 09/18] libselinux: label_file: fix potential read past buffer in spec_hasMetaChars
Date: Fri, 31 Aug 2012 10:49:45 -0700
Message-Id: <1346435394-1954-9-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An illegal regex may end with a single \ followed by nul.  This could
cause us to search past the end of the character array.  The loop
formation looks like so:

        c = regex_str;
        len = strlen(c);
        end = c + len;

        while (c != end) {
		switch (*c) {
		...
                case '\\':      /* skip the next character */
                        c++;
                        break;
		...
                }
                c++;
	}

If the \ is the last character then we will increment c and break from
the switch.  The while loop will then increment c.  So now c == end+1.
This means we will keep running into infinity and beyond!  Easy fix.
Make the loop check (c < end).  Thus even if we jump past end, we still
exit the loop.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index b839a23..e520acc 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -88,7 +88,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
 
 	/* Look at each character in the RE specification string for a 
 	 * meta character. Return when any meta character reached. */
-	while (c != end) {
+	while (c < end) {
 		switch (*c) {
 		case '.':
 		case '^':
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
