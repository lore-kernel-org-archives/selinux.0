MIME-Version: 1.0
Date: Mon, 10 Sep 2012 11:07:21 +0300
Message-ID: <CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
Subject: Security hooks for rpm
From: Elena Reshetova <elena.reshetova@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

As we agreed during the LSS Iet's try to define a unified set of
security hooks for rpm.
I have promised to post the set of hooks that we are proposing. I
think we can try first to agree on the hooks and they arguments and
then agree about their place. I can make the needed adjustments on the
actual code.

Also I have been thinking that since we are talking more and more
about stackable LSMs, then security plug-in interface for rpm should
support multiple security plug-ins in case package comes with
configurations for a number of LSMs (also things like IMA/EVM setup
can be moved to a separate plug-in).
What do you think about it?

All current hooks return rpmRC error code, which is RPMRC_OK, if no
errors are detected and RPMRC_FAIL, if failure is detected and
installation must be aborted.

And here are the actual hooks:

1. rpmRC SECURITYHOOK_INIT_FUNC(rpmts ts, const char *opts)

This hook should be used by the security plug-in to initialize itself
and its data.

2. rpmRC SECURITYHOOK_CLEANUP_FUNC(void)

This hook should be used by the plug-in to free any allocated memory
and finish its execution.

3. rpmRC SECURITYHOOK_PRE_TSM_FUNC(rpmts _ts)

This hook is called before the beginning of rpm transaction and allows
the plug-in to perform the pre-checks on the group of packages to be
installed.

4. rpmRC SECURITYHOOK_POST_TSM_FUNC(rpmts _ts)

This hook is called after the rpm transaction has finished. It allows
the security plug-in to perform any post-transaction checks or
additional processing.

5. rpmRC SECURITYHOOK_PRE_PSM_FUNC(rpmte _te)

This hook is called before the installation/removal of a single
package begins. If the rpm transaction contains multiple packages,
this hook will be called for each package separately. Using this hook
rpm security plugin is able to do any processing per each package.

6. rpmRC SECURITYHOOK_POST_PSM_FUNC(rpmte _te, int rpmrc)

This hook is called after the installation/removal of a single
package. If the rpm transaction contains multiple packages, this hook
will be called for each package separately. This can be a good place
to do some verification that installation went successfully and
perform needed cleanups per package-basis if needed.

7. rpmRC SECURITYHOOK_SCRIPT_EXEC_FUNC(ARGV_const_t argv)

This hook is called before any maintainer script is executed and hook
gets full set of command line script parameters. It is a
responsibility of the hook to call execution of the script and provide
the exit status. This hook should be used by a security plug-in to
setup a proper security context for the script execution and then
execute the script.

8. rpmRC SECURITYHOOK_FSM_OPENED_FUNC(const char* dirName, const char* baseName)

This is first of the three file hooks that are needed by the security
plugin to perform an operation of a certain file from the package.
This hook is called before the file is read from the archive. The
dirName and baseName allow to reconstruct the path of the file to be
place to the filesystem.

9. rpmRC SECURITYHOOK_FSM_UPDATED_FUNC(const struct stat * st, char
*buf, size_t len)

This is the second of the file hooks. It is called a number of times
depending on the file length every time a new chunk of file is read
from the archive to the buffer. The actual buffer and its length is
provided in the parameters.

10. rpmRC SECURITYHOOK_FSM_CLOSED_FUNC(int rpmrc)

The last file hook allows the plugin to finish the file processing. It
is called once per each file from the package and after the file has
been placed to the filesystem. Can be used to label the file.

11. rpmRC SECURITYHOOK_VERIFY_FUNC(rpmKeyring keyring, rpmtd sigtd,
pgpDigParams sig, rpmRC rpmrc)

The main purpose of this hook is to give ability for a security plugin
to perform its own independent (and potentially stricter) control over
the package verification. It also allows a security plugin to store
the information about the package source in its internal metadata
(potentially stricter controlled) in order to enforce its own
policies. In MSM security plug-in this hook is used to verify the SW
source of the package using its internal database of trusted keys. The
primary reason for having its own database is an ability to strictly
control the software keys and don't mix them with other keys that
might be on the system's keyring. In Tizen OS in the future there is a
plan to use a separate Certificate Manager in order to store and
manage the system code certificates. This hook can also use the
keyring to perform similar to rpm verification of package, if no
internal database of keys exist.

12. rpmRC SECURITYHOOK_FILE_CONFLICT_FUNC(rpmts ts, rpmte te, rpmfi
fi, Header oldHeader, rpmfi oldFi, int rpmrc)

This hook can be used by the plug-ins in order to enforce stricter
control over the case when files on the disk can be overwritten by
newly installed packages. The basic rpm doesn't allow such cases by
default, but it has an option ("--replacefiles") that allows such
overwriting to happen. However from the security point of view it
should not be possible to substitute system binaries or components
from a package that is coming from an untrusted source. Such hook
provides a possibility to monitor such cases and deny the
installation.

Best Regards,
Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
