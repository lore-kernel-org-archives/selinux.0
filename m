Subject: Re: getpidcon with pid == 0 (Was: Re: [PATCH 2/2] libselinux:
 procattr: return einval for <= 0 pid args.)
To: Nick Kralevich <nnk@google.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
 <56CDC2EC.5050502@tycho.nsa.gov>
 <CAFJ0LnHvFe6PkGp2BGKj-cQ-e11kFo9DacB_MbP9xFmi5S=DNA@mail.gmail.com>
Cc: Daniel Cashman <dcashman@android.com>, SELinux <selinux@tycho.nsa.gov>,
 Jeffrey Vander Stoep <jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56CDCCFD.9020009@tycho.nsa.gov>
Date: Wed, 24 Feb 2016 10:32:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHvFe6PkGp2BGKj-cQ-e11kFo9DacB_MbP9xFmi5S=DNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/24/2016 10:25 AM, Nick Kralevich wrote:
> A quick Google search for "getpidcon(0" shows only the Android bug.
>
> https://www.google.com/webhp#q=%22getpidcon(0%22
>
> -- Nick

Yes, I looked through searchcode.com results for getpidcon (not just 
with a hardcoded 0 but also looking for any cases where they assume that 
setting a variable pid == 0 degenerates to getcon behavior), and didn't 
see anything.

I've also asked the Fedora SELinux maintainers if they know of anything 
that would break.

>
> On Wed, Feb 24, 2016 at 6:49 AM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>
>     On 02/23/2016 03:24 PM, Daniel Cashman wrote:
>
>         From: dcashman <dcashman@android.com <mailto:dcashman@android.com>>
>
>         getpidcon documentation does not specify that a pid of 0 refers
>         to the
>         current process, and getcon exists specifically to provide this
>         functionality, and getpidcon(getpid()) would provide it as well.
>         Disallow pid values <= 0 that may lead to unintended behavior in
>         userspace object managers.
>
>
>     I'll try to see if there are any legitimate users of getpidcon with
>     pid == 0.  If anyone on the list knows of one, please speak up.
>
>
>         Signed-off-by: Daniel Cashman <dcashman@android.com
>         <mailto:dcashman@android.com>>
>         ---
>            libselinux/src/procattr.c | 14 ++++++++++++--
>            1 file changed, 12 insertions(+), 2 deletions(-)
>
>         diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
>         index c20f003..eee4612 100644
>         --- a/libselinux/src/procattr.c
>         +++ b/libselinux/src/procattr.c
>         @@ -306,11 +306,21 @@ static int setprocattrcon(const char *
>         context,
>            #define getpidattr_def(fn, attr) \
>                  int get##fn##_raw(pid_t pid, char **c)  \
>                  { \
>         -               return getprocattrcon_raw(c, pid, #attr); \
>         +               if (pid <= 0) { \
>         +                       errno = EINVAL; \
>         +                       return -1; \
>         +               } else { \
>         +                       return getprocattrcon_raw(c, pid, #attr); \
>         +               } \
>                  } \
>                  int get##fn(pid_t pid, char **c)        \
>                  { \
>         -               return getprocattrcon(c, pid, #attr); \
>         +               if (pid <= 0) { \
>         +                       errno = EINVAL; \
>         +                       return -1; \
>         +               } else { \
>         +                       return getprocattrcon(c, pid, #attr); \
>         +               } \
>                  }
>
>            all_selfattr_def(con, current)
>
>
>
>
>
> --
> Nick Kralevich | Android Security | nnk@google.com
> <mailto:nnk@google.com> | 650.214.4037
