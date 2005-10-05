Message-ID: <43436F35.4040204@cmcrc.com>
Date: Wed, 05 Oct 2005 16:14:13 +1000
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: matchpathcon regcomp return code
Content-Type: multipart/mixed;
 boundary="------------010307050103040500040100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010307050103040500040100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi list,

Well, first message here (yeah).

I have a double problem with restorecon crashing with a segfault.

Some background of the situation:
using centos4 with a cutsomized (not much) targeted selinux policy.
Trying to make the httpd server access /var/lib/svn (svn repositories)
which is a separate ext3 fs.

so basically, I changed the src/policy/file_contexts/types.fc and added
'/var/lib/svn/lost\+found(/.*)?  system_u:object_r:lost_found_t'
to keep my lost+found dir secured.

and changed my apache.fc file to add /var/lib/svn(/.*) to another type
accessible by apache (let's say system_u:object_r:httpd_sys_content_t
but could be anything else...)

Anyway, This configuration will not work as expected since the apache.fc
file is concatened after the types.fc, the lost+found will get the
httpd_sys_content_t type....

So I tried to use a bit of regex and set up a look ahead assertion to
avoid the lost+found and use the following regex (tested with perl happily):

/var/lib/svn(?!(/.*)?/lost\\+found)(/.*)?

Now the problem is restorecon is crashing (segfault in matchpathcon)

About the crashing, it seems that the error code check of regcomp in
matchpathcon.c is wrong (see attached patch from CVS HEAD).

The second question is actually, is lookaround supported at all in posix
regex ?

Cheers.
J.

-- 
Johan Fischer
Capital Markets CRC Limited
Level 2, 9 Castlereagh Street, Sydney NSW 2000
Tel: +61 2 9233 7999   Direct: +61 2 9236 9150
Fax: +61 2 9236 9177   http://www.cmcrc.com

Capital Markets CRC Ltd (CMCRC) - Confidential Communication
The information contained in this e-mail is confidential.  It is intended solely for the addressee. If you receive this e-mail by mistake please promptly inform us by reply e-mail and then delete the e-mail and destroy any printed copy. You must not disclose or use in any way the information in the e-mail. There is no warranty that this e-mail is error or virus free. It may be a private communication, and if so, does not represent the views of the CMCRC and its associates. If it is a private communication, care should be taken in opening it to ensure that undue offence is not given.


--------------010307050103040500040100
Content-Type: text/plain;
 name="matchpathcon.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="matchpathcon.c.diff"

--- matchpathcon.c	2005-10-05 15:33:38.000000000 +1000
+++ matchpathcon.c.new	2005-10-05 15:33:26.000000000 +1000
@@ -501,7 +501,7 @@
 			regcomp(&spec_arr[nspec].regex,
 				anchored_regex,
 				REG_EXTENDED | REG_NOSUB);
-		if (regerr < 0) {
+		if (regerr != 0) {
 			myprintf("%s:  line %d has invalid regex %s\n", path, lineno, anchored_regex); 
 			free(anchored_regex);
 			return 0;

--------------010307050103040500040100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
