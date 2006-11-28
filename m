Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kASNtGmM026521
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 18:55:16 -0500
Received: from iron2-smtp.tops.gwu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kASNsZQv025700
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 23:54:35 GMT
From: Yuichi Nakamura <ynakam@gwu.edu>
To: selinux@tycho.nsa.gov
Cc: kaigai@kaigai.gr.jp
Message-ID: <ddeda73453a4.456d4b0b@gwu.edu>
Date: Wed, 29 Nov 2006 08:55:39 +0900
MIME-Version: 1.0
Subject: First argument of matchpathcon_filespec_add
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We are porting SELinux commands to busybox with friends.
# Patch set will be released in near future..

In the process, we found problem in matchpathcon_filespec_add.

1) I tried to port setfiles.c to busybox. 
    I ran setfiles command from busybox, but it crashed in following(line 313): "matchpathcon_filespec_add".

   * setfiles.c
   307           * Try to add an association between this inode and
   308           * this specification.  If there is already an association
   309           * for this inode and it conflicts with this specification,
   310           * then use the last matching specification.
   311           */
   312          if (add_assoc) {
   313                  j = matchpathcon_filespec_add(my_sb.st_ino, i, my_file);
   314                  if (j < 0)
   315                          goto err;
   316
   317                  if (j != i) {
   318                          /* There was already an association and it took
precedence. */
   319                          goto out;


2) I found the reason why it crashed is size of mysb.st_ino is different between libselinux and busybox.

Prototype of matchpathcon_filespec_add is:
int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)

The size of "ino_t" is diffenrent in busybox and libselinux.
Size of ino_t changes according to value of _FILE_OFFSET_BIT.
When libselinux is built, "-D_FILE_OFFSET_BIT=64" is defined.
However, in busybox "-D_FILE_OFFSET_BIT=64" is not defined, it depends on busybox configuration.

When we do not want to build busybox with -D_FILE_OFFSET_BIT=64,
we have to rebuild libselinux.

I think it is a problem.

Does anyone have good idea ?

--
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
