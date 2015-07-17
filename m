Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6HDXcZk025184
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 09:33:38 -0400
Received: by wgkl9 with SMTP id l9so82374834wgk.1
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 06:33:36 -0700 (PDT)
Date: Fri, 17 Jul 2015 17:33:33 +0400
From: Jason Zaman <jason@perfinion.com>
To: Robert Kuska <rkuska@redhat.com>
Subject: Re: Python3 Support for Sepolgen module
Message-ID: <20150717133333.GA18060@meriadoc.Home>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
 <20150716221605.GB28538@meriadoc.Home>
 <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
 <20150717065802.GA12312@meriadoc.Home>
 <1799051406.34694801.1437118108180.JavaMail.zimbra@redhat.com>
 <20150717075654.GA13727@meriadoc.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717075654.GA13727@meriadoc.Home>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 17, 2015 at 11:56:54AM +0400, Jason Zaman wrote:
> On Fri, Jul 17, 2015 at 03:28:28AM -0400, Robert Kuska wrote:
> > Looking at policycoreutils-python3 it seems to me that sepolicy and seobject are already ported.
> 
> Hmm I suspect thats not right cuz I kept getting errors when using it.
> When I looked through as well, I saw lots of places where print() needs
> to be fixed as well as "except Error, e" and quite a lot of mixed tabs
> and spaces. 2to3 can fix most of that automatically tho.
> 
> As far as actual incompatibilities, I only saw a few issues with
> subcommand / process and str / unicode for internationalization so it
> should be pretty easy to fix up.
> 
> -- Jason

I keep hitting this with python3, it seems to be much stricter than py2:

# semanage boolean -l
Traceback (most recent call last):
  File "/usr/lib/python-exec/python3.3/semanage", line 27, in <module>
    import seobject
  File "/usr/lib64/python3.3/site-packages/seobject.py", line 154
    context = "%s%s" % (filler, raw)
                                   ^
TabError: inconsistent use of tabs and spaces in indentation

I want to fix all the whitespace and other style issues in one big pull
request. Will it cause big problems for your porting? The upside is that
it's only a one time issue for the repo.

If there are no objections, I'll send a pull request with the fix
shortly. It is too big for an inline patch.

-- Jason
