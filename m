Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBHEGkVr018696
 for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2015 09:16:46 -0500
Subject: Re: [PATCH] policycoreutils/chcat: Add a fallback in case
 os.getlogin() returns nothing
To: Laurent Bigonville <bigon@debian.org>, <selinux@tycho.nsa.gov>
References: <1450046440-25449-1-git-send-email-bigon@bigon.be>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <5672C3BF.5000800@tresys.com>
Date: Thu, 17 Dec 2015 09:16:31 -0500
MIME-Version: 1.0
In-Reply-To: <1450046440-25449-1-git-send-email-bigon@bigon.be>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/13/2015 05:40 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Some teminal emulators (like the latest version of gnome-terminal) are
> not setting entries in the utmp file, this leads getlogin() to return an
> empty string.
> 
> Fallback to the name of the user running the chcat process.

Applied. Thanks.

Also, in the future, please add a Signed-off-by line.

> ---
>  policycoreutils/scripts/chcat | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
> index ec527e5..472785c 100755
> --- a/policycoreutils/scripts/chcat
> +++ b/policycoreutils/scripts/chcat
> @@ -372,7 +372,10 @@ def listcats():
>  
>  def listusercats(users):
>      if len(users) == 0:
> -        users.append(os.getlogin())
> +        try:
> +            users.append(os.getlogin())
> +        except:
> +            users.append(pwd.getpwuid(os.getuid()).pw_name)
>  
>      verify_users(users)
>      for u in users:
> 
