Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s06Fv8rU004206
 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2014 10:57:09 -0500
Message-ID: <52CAD237.3060701@redhat.com>
Date: Mon, 06 Jan 2014 10:56:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: mthode@mthode.org, selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org> <52C27333.3060801@networkcrypt.com>
 <52C31282.6080809@mthode.org>
In-Reply-To: <52C31282.6080809@mthode.org>
Content-Type: multipart/mixed; boundary="------------090409030407060105090500"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------090409030407060105090500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/31/2013 01:52 PM, Matthew Thode wrote:
> On 12/31/2013 01:33 AM, Francis Cunnane wrote:
>> What do you propose....  This is free software.... Don't be a Jew.
>> 
>> On 12/30/2013 7:11 PM, Matthew Thode wrote:
>>> On 12/30/2013 10:11 AM, Stephen Smalley wrote:
>>>> Calling *setfilecon() with a NULL context is a bug in the caller,
>>>> just like calling strlen() with a NULL string. Fix the callers,
>>>> please.
>>>> 
>>>> On Wed, Dec 25, 2013 at 9:36 AM, Nicolas Iooss 
>>>> <nicolas.iooss@m4x.org> wrote:
>>>>> 2013/12/23 Daniel J Walsh wrote:
>>>>>> On 12/21/2013 09:27 AM, Nicolas Iooss wrote:
>>>>>>> My first message was not so clear. The check in 
>>>>>>> libselinux/src/lsetfilecon.c line 35 [1] doesn't work because 
>>>>>>> selinux_trans_to_raw_context(context, &rcontext) returns 0 and
>>>>>>> sets rcontext to NULL. This is why I'm asking to change the
>>>>>>> return value to something else if you want "cp -a" working.
>>>>>>> This fix is not to introduce a new feature but to fix an
>>>>>>> existing one.
>>>>>>> 
>>>>>>> Nicolas
>>>>>>> 
>>>>>> How about if we add a check on lsetfilecon_raw?  Changing the 
>>>>>> behaviour on selinux_trans_to_raw_context might cause other
>>>>>> problems.
>>>>> I agree. I've found 
>>>>> http://selinuxproject.org/page/LibselinuxAPISummary which says 
>>>>> precisely for selinux_trans_to_raw_context: "If passed NULL, sets
>>>>> the returned context to NULL and returns 0." As this feature is 
>>>>> documented, callers may rely on it and changing this behavior is 
>>>>> likely to break things.
>>>>> 
>>>>> Moreover setfilecon_raw and fsetfilecon_raw have the same
>>>>> NULL-pointer dereference issue. Do these functions need a patch
>>>>> too?
>>>>> 
>>>>> By the way, other callers of selinux_trans_to_raw_context may also 
>>>>> share this bug: avc_context_to_sid, security_canonicalize_context, 
>>>>> security_check_context, etc. Is doing a segmentation fault the 
>>>>> expected way to tell the caller it used a NULL pointer and should
>>>>> have manually checked every parameter before calling any
>>>>> libselinux function?
>>>>> 
>>>>> Thanks and merry Christmas!
>>>>> 
>>>>> Nicolas
>>>>> 
>>>>>> 
>>>>>> diff --git a/libselinux/src/lsetfilecon.c 
>>>>>> b/libselinux/src/lsetfilecon.c index 461e3f7..af3775e 100644 -
>>>>>> --- a/libselinux/src/lsetfilecon.c +++
>>>>>> b/libselinux/src/lsetfilecon.c @@ -9,6 +9,10 @@
>>>>>> 
>>>>>> int lsetfilecon_raw(const char *path, const security_context_t 
>>>>>> context) { +       if (! context) { +
>>>>>> errno=EINVAL; +               return -1; +       } return
>>>>>> lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1 
>>>>>> 0); }
>>>>> _______________________________________________ Selinux mailing
>>>>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>>>>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>>>>> "help" to Selinux-request@tycho.nsa.gov.
>>>> _______________________________________________ Selinux mailing list 
>>>> Selinux@tycho.nsa.gov To unsubscribe, send email to
>>>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>>>> "help" to Selinux-request@tycho.nsa.gov.
>>>> 
>>> I think I may have hit this bug as well.
>>> 
>>> https://bugs.gentoo.org/show_bug.cgi?id=495274
>>> 
>>> 
>>> 
>>> _______________________________________________ Selinux mailing list 
>>> Selinux@tycho.nsa.gov To unsubscribe, send email to
>>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>>> "help" to Selinux-request@tycho.nsa.gov.
>> 
>> 
>> 
>> 
>> _______________________________________________ Selinux mailing list 
>> Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
>> to Selinux-request@tycho.nsa.gov.
>> 
> If I had any more info in the bug report then what was mentioned here, it
> was meant to help.  Also, on vacation, so won't be of much help this week
> :P
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 

How about this patch?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLK0jcACgkQrlYvE4MpobN0RgCfafbSstZ1FK+PDvqIsEjxYo3O
iz8AoLadj5UAqzD4Nw3+qyfK+s/vfThu
=GLwc
-----END PGP SIGNATURE-----

--------------090409030407060105090500
Content-Type: text/x-patch;
 name="0001-Verify-context-input-to-funtions-to-make-sure-the-co.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Verify-context-input-to-funtions-to-make-sure-the-co.pa";
 filename*1="tch"

>From 1a9ef9cd4fe84f590ff9b0d7b402d68220922d7a Mon Sep 17 00:00:00 2001
From: Dan Walsh <dwalsh@redhat.com>
Date: Mon, 23 Dec 2013 09:50:54 -0500
Subject: [PATCH] Verify context input to funtions to make sure the context
 field is not null.

Return errno EINVAL, to prevent segfault.
---
 libselinux/src/avc_sidtab.c           | 5 +++++
 libselinux/src/canonicalize_context.c | 5 +++++
 libselinux/src/check_context.c        | 5 +++++
 libselinux/src/compute_av.c           | 5 +++++
 libselinux/src/compute_create.c       | 5 +++++
 libselinux/src/compute_member.c       | 5 +++++
 libselinux/src/compute_relabel.c      | 5 +++++
 libselinux/src/compute_user.c         | 5 +++++
 libselinux/src/fsetfilecon.c          | 8 ++++++--
 libselinux/src/lsetfilecon.c          | 9 +++++++--
 libselinux/src/setfilecon.c           | 8 ++++++--
 11 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 0b696bb..506e236 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -81,6 +81,11 @@ sidtab_context_to_sid(struct sidtab *s,
 	int hvalue, rc = 0;
 	struct sidtab_node *cur;
 
+	if (! ctx) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	*sid = NULL;
 	hvalue = sidtab_hash(ctx);
 
diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index 176c45a..6075025 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -17,6 +17,11 @@ int security_canonicalize_context_raw(const security_context_t con,
 	size_t size;
 	int fd, ret;
 
+	if (! con) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	if (!selinux_mnt) {
 		errno = ENOENT;
 		return -1;
diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
index 33ab5e3..1277bdd 100644
--- a/libselinux/src/check_context.c
+++ b/libselinux/src/check_context.c
@@ -14,6 +14,11 @@ int security_check_context_raw(const security_context_t con)
 	char path[PATH_MAX];
 	int fd, ret;
 
+	if (! con) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	if (!selinux_mnt) {
 		errno = ENOENT;
 		return -1;
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 5962c0b..61ea454 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -26,6 +26,11 @@ int security_compute_av_flags_raw(const security_context_t scon,
 		return -1;
 	}
 
+	if ((! scon) || (! tcon)) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	snprintf(path, sizeof path, "%s/access", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 3c05be3..34a1ccd 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -64,6 +64,11 @@ int security_compute_create_name_raw(const security_context_t scon,
 		return -1;
 	}
 
+	if ((! scon) || (! tcon)) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	snprintf(path, sizeof path, "%s/create", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index dad0a77..7850986 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -25,6 +25,11 @@ int security_compute_member_raw(const security_context_t scon,
 		return -1;
 	}
 
+	if ((! scon) || (! tcon)) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	snprintf(path, sizeof path, "%s/member", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index 656f00a..2560e78 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -25,6 +25,11 @@ int security_compute_relabel_raw(const security_context_t scon,
 		return -1;
 	}
 
+	if ((! scon) || (! tcon)) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index 3b39ddd..af20735 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -24,6 +24,11 @@ int security_compute_user_raw(const security_context_t scon,
 		return -1;
 	}
 
+	if (! scon) {
+		errno=EINVAL;
+		return -1;
+	}
+
 	snprintf(path, sizeof path, "%s/user", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index 9963f7a..37f9d74 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -9,8 +9,12 @@
 
 int fsetfilecon_raw(int fd, const security_context_t context)
 {
-	int rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
-			 0);
+	int rc;
+	if (! context) {
+		errno=EINVAL;
+		return -1;
+	}
+	rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
 	if (rc < 0 && errno == ENOTSUP) {
 		security_context_t ccontext = NULL;
 		int err = errno;
diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index fd9bb26..af2d88c 100644
--- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -9,8 +9,13 @@
 
 int lsetfilecon_raw(const char *path, const security_context_t context)
 {
-	int rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
-			 0);
+	int rc;
+	if (! context) {
+		errno=EINVAL;
+		return -1;
+	}
+
+	rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
 	if (rc < 0 && errno == ENOTSUP) {
 		security_context_t ccontext = NULL;
 		int err = errno;
diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c
index 50cb228..e617039 100644
--- a/libselinux/src/setfilecon.c
+++ b/libselinux/src/setfilecon.c
@@ -9,8 +9,12 @@
 
 int setfilecon_raw(const char *path, const security_context_t context)
 {
-	int rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
-			0);
+	int rc;
+	if (! context) {
+		errno=EINVAL;
+		return -1;
+	}
+	rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1, 0);
 	if (rc < 0 && errno == ENOTSUP) {
 		security_context_t ccontext = NULL;
 		int err = errno;
-- 
1.8.5.2


--------------090409030407060105090500--
