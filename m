Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HFThMS001319
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 11:29:43 -0400
Subject: Re: Python3 Support for Sepolgen module
To: Jason Zaman <jason@perfinion.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
 <20150716221605.GB28538@meriadoc.Home>
 <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
 <20150717065802.GA12312@meriadoc.Home>
 <1799051406.34694801.1437118108180.JavaMail.zimbra@redhat.com>
 <20150717075654.GA13727@meriadoc.Home> <20150717133333.GA18060@meriadoc.Home>
From: Michal Srb <msrb@redhat.com>
Message-ID: <55A91F50.9070307@redhat.com>
Date: Fri, 17 Jul 2015 17:29:20 +0200
MIME-Version: 1.0
In-Reply-To: <20150717133333.GA18060@meriadoc.Home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 07/17/2015 03:33 PM, Jason Zaman wrote:
> I keep hitting this with python3, it seems to be much stricter than py2:
>
> # semanage boolean -l
> Traceback (most recent call last):
>    File "/usr/lib/python-exec/python3.3/semanage", line 27, in <module>
>      import seobject
>    File "/usr/lib64/python3.3/site-packages/seobject.py", line 154
>      context = "%s%s" % (filler, raw)
>                                     ^
> TabError: inconsistent use of tabs and spaces in indentation
>
> I want to fix all the whitespace and other style issues in one big pull
> request. Will it cause big problems for your porting? The upside is that
> it's only a one time issue for the repo.
>
> If there are no objections, I'll send a pull request with the fix
> shortly. It is too big for an inline patch.

Hi Jason,

I am preparing patches for adding python3 support to scripts under 
policycoreutils/. No objections from me, please go ahead and apply your 
changes. I can rebase my patches, if there are any problems.

Regards
Michal


>
> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
