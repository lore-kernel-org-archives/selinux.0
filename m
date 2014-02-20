Date: Thu, 20 Feb 2014 18:47:49 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
To: Lennart Poettering <lennart@poettering.net>
In-Reply-To: <20140220183643.GB24876@tango.0pointer.de>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-wtrdSIVbGiyKy2wUk/Vp"
Message-Id: <20140220185250.6F0E0680112@frontend2.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-wtrdSIVbGiyKy2wUk/Vp
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, Feb 20, 2014 at 1:36 PM, Lennart Poettering 
<lennart@poettering.net> wrote:
> On Thu, 20.02.14 18:17, Colin Walters (walters@verbum.org) wrote:
> 
> Hmm, maybe a simple check access("/etc/selinux/", F_OK) would be 
> enough?
> There's no point in trying to initialized SELinux if that dir does not
> exist, right? Then we could simply bypass the whole thing...
> 

Beyond what Eric said, I also think that libselinux should continue to 
contain all of the key logic for whether or not SELinux is enabled and 
how to behave.

The current *API* seems OK in having the two return values of an error 
code and an enforcing flag.

The only thing libselinux can't know is:
1) Whether we're inside an initramfs right now
2) Whether or not the OS vendor expects policy to be found in the real 
root or the initramfs

So those bits of logic make sense to me in systemd, although there is 
an argument for #2 living in libselinux.




--=-wtrdSIVbGiyKy2wUk/Vp
Content-Type: text/html; charset=utf-8

On Thu, Feb 20, 2014 at 1:36 PM, Lennart Poettering &lt;lennart@poettering.net&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">On Thu, 20.02.14 18:17, Colin Walters (walters@verbum.org) wrote:

Hmm, maybe a simple check access("/etc/selinux/", F_OK) would be enough?
There's no point in trying to initialized SELinux if that dir does not
exist, right? Then we could simply bypass the whole thing...</div></blockquote><div><br></div><div>Beyond what Eric said, I also think that libselinux should continue to contain all of the key logic for whether or not SELinux is enabled and how to behave.</div><div><br></div><div>The current *API* seems OK in having the two return values of an error code and an enforcing flag.</div><div><br></div><div>The only thing libselinux can't know is:</div><div>1) Whether we're inside an initramfs right now</div><div>2) Whether or not the OS vendor expects policy to be found in the real root or the initramfs</div><div><br></div><div>So those bits of logic make sense to me in systemd, although there is an argument for #2 living in libselinux.</div><div><br></div><div><br></div>
--=-wtrdSIVbGiyKy2wUk/Vp--
