Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1J0Xqt3007103
 for <selinux@tycho.nsa.gov>; Tue, 18 Feb 2014 19:33:53 -0500
Date: Wed, 19 Feb 2014 00:28:50 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: cross-labeling vs precompiled PCRE
To: Eric Paris <eparis@parisplace.org>
In-Reply-To: <CACLa4pu0iRVpJuWe+B01H-5CEghcWdoYsGdeSO5=V8CzrLQ01w@mail.gmail.com>
References: <20140218212318.361DD680123@frontend2.nyi.mail.srv.osa>
 <CACLa4pu0iRVpJuWe+B01H-5CEghcWdoYsGdeSO5=V8CzrLQ01w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-VbytpuBtIitj2gwi8ACo"
Message-Id: <20140219003351.33C4A680126@frontend2.nyi.mail.srv.osa>
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-VbytpuBtIitj2gwi8ACo
Content-Type: text/plain; charset=utf-8; format=flowed

On Tue, Feb 18, 2014 at 4:45 PM, Eric Paris <eparis@parisplace.org> 
wrote:
> agreed completely that a version check makes sense, but i'm pretty
> sure I'll forget about it before I have time to look at it   :-(
> 
I'm happy to do some implementation work here myself as well.  The 
obvious thing to do is just to stick the output of pcre_version() into 
the file - except there's no space.  So we'd need to bump the format 
version.

Now I can do that, but I think it's the kind of thing that needs a bit 
of discussion beforehand.  Any objections or further thoughts?

In the meantime though, I'm going to have to hack up my copy of 
libselinux from RHEL7 to just ignore the .bin files unconditionally.



--=-VbytpuBtIitj2gwi8ACo
Content-Type: text/html; charset=utf-8

On Tue, Feb 18, 2014 at 4:45 PM, Eric Paris &lt;eparis@parisplace.org&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">agreed completely that a version check makes sense, but i'm pretty
sure I'll forget about it before I have time to look at it   :-(</div></blockquote><br><div>I'm happy to do some implementation work here myself as well. &nbsp;The obvious thing to do is just to stick the output of pcre_version() into the file - except there's no space. &nbsp;So we'd need to bump the format version.</div><div><br></div><div>Now I can do that, but I think it's the kind of thing that needs a bit of discussion beforehand. &nbsp;Any objections or further thoughts?</div><div><br></div><div>In the meantime though, I'm going to have to hack up my copy of libselinux from RHEL7 to just ignore the .bin files unconditionally.</div><div><br></div>
--=-VbytpuBtIitj2gwi8ACo--
