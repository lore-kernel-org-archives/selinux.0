Subject: Re: chcat is using getlogin() function that sometimes returns
 null/empty string
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <5665C991.4030606@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5665E4A1.50108@tycho.nsa.gov>
Date: Mon, 7 Dec 2015 14:57:21 -0500
MIME-Version: 1.0
In-Reply-To: <5665C991.4030606@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/07/2015 01:01 PM, Laurent Bigonville wrote:
> Hi,
>
> So apparently gnome-terminal developers have decided to stop updating
> utmp[0] file and this is breaking chcat -Ll with the following error:
>
> Traceback (most recent call last):
>    File "/usr/bin/chcat", line 409, in <module>
>      sys.exit(listusercats(cmds))
>    File "/usr/bin/chcat", line 352, in listusercats
>      users.append(os.getlogin())
> OSError: [Errno 2] No such file or directory
>
> getlogin(3) manpage suggest to rely on the LOGNAME environment variable,
> so maybe chcat should fallback to this if getlogin() is not returning
> anything?
>
> Cheers,
>
> Laurent Bigonville
>
> [0] https://bugzilla.gnome.org/show_bug.cgi?id=747046

Maybe just use:
pwd.getpwuid(os.getuid()).pw_name
