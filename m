Message-ID: <47C70D14.2020406@redhat.com>
Date: Thu, 28 Feb 2008 14:35:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux does not work properly in upstart/initrd
References: <47C6F067.5050209@redhat.com>	 <1204223131.31790.161.camel@moss-spartans.epoch.ncsc.mil>	 <47C701F9.1090706@redhat.com> <1204226357.31790.198.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204226357.31790.198.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060700060200000803080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060700060200000803080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2008-02-28 at 13:48 -0500, Daniel J Walsh wrote:
> Stephen Smalley wrote:
>>>> On Thu, 2008-02-28 at 12:33 -0500, Daniel J Walsh wrote:
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=434793
>>>>>
>>>>> The way the upstart initrd works is to run nash with a builtin
>>>>> loadpolicy.  The problem is nash starts before the /sysmount files
>>>>> system is mounted, so libselinux does not have an /etc/selinux/config to
>>>>> read.  It defaults to targeted.  So when nash finally executes
>>>>> loadpolicy (selinux_init_load_policy) it has the wrong config.
>>>>> Switching to any other type of policy will fail and
>>>>> selinux_init_load_policy will look for targeted.
>>>>>
>>>>> I changed this function to reload the config, to fix this problem.
>>>>>
>>>>> I think I did all the hidden stuff correctly.  I don't think we want to
>>>>> expose these functions.
>>>> To make a function hidden, just mark it with hidden.
>>>> hidden_def and hidden_proto are about creating a private definition
>>>> within the library for intra-library calls that do not cause a
>>>> relocation, not about hiding the definition altogether.
>>>>
> So the hidden_def and hidden_proto lines can be removed as login as the
> extern hidden remains.
>>>> Concerns about this patch:
>>>> - it isn't thread safe,
> selinux_init_load_policy should not be called repeatedly, or probably
> from a threaded app.
>>>> - it only "fixes" the load policy case, not any other libselinux
>>>> function call.
> Well this is a very strange occurrance where the config is not there and
> then when the function gets called, it is there.
> 
>> Fair enough - we can just handle this specific case then.
>> I'd suggest a single reset_selinux_config() or similar function added to
>> src/selinux_config.c that does the fini_ and init_ calls internally, and
>> then call that single function from load policy.
> 
>>>> As an alternative, maybe we should revive Steve Grubb's lazy init patch
>>>> for libselinux?  That won't reload each time, but will defer the initial
>>>> reading until you first invoke a libselinux function.  The last version
>>>> of the patch that I saw is attached.
>>>>
>>>>
>>
- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

New simplified patch to reset the selinux_config.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfHDRMACgkQrlYvE4MpobNEjACgygyCp4ISNXrpMajwozPEbqwH
2kQAoLgnTNDv9KlsFpIBGGYnCEFHThfA
=HcRn
-----END PGP SIGNATURE-----

--------------060700060200000803080208
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/load_policy.c libselinux-2.0.57/src/load_policy.c
--- nsalibselinux/src/load_policy.c	2008-02-13 11:16:14.000000000 -0500
+++ libselinux-2.0.57/src/load_policy.c	2008-02-28 14:30:24.000000000 -0500
@@ -308,6 +308,12 @@
 	FILE *cfg;
 	char *buf;
 
+
+	/*
+	  Reinitialize the library, so chroot will work correctly.
+	 */
+	reset_selinux_config();
+
 	/*
 	 * Get desired mode (disabled, permissive, enforcing) from 
 	 * /etc/selinux/config. 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-2.0.57/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.57/src/selinux_config.c	2008-02-28 14:33:02.000000000 -0500
@@ -223,6 +223,12 @@
 	selinux_policytype = NULL;
 }
 
+void reset_selinux_config(void)
+{
+	fini_selinux_policyroot();
+	init_selinux_config();
+}
+
 static const char *get_path(int idx)
 {
 	return file_paths[idx];
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-2.0.57/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2007-08-03 16:02:56.000000000 -0400
+++ libselinux-2.0.57/src/selinux_internal.h	2008-02-28 14:30:24.000000000 -0500
@@ -80,6 +80,7 @@
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 
+extern void reset_selinux_config(void) hidden;
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;

--------------060700060200000803080208
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkfHDRMACgkQrlYvE4MpobMMMwCgxbaBzuwLTqvTRgwtpvj5YEixqLAAn1yE
n3GAkjfoesjsGpo37YUEmk4g
--------------060700060200000803080208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
