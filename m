Date: Thu, 4 Nov 2004 14:46:59 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Chad Hanson <chanson@TrustedCS.com>, Karl MacMillan <kmacmillan@tresys.com>,
   Frank Mayer <mayerf@tresys.com>, Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
In-Reply-To: <1099587019.3174.137.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0411041444530.19977-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Nov 2004, Stephen Smalley wrote:

> policy?  Implementing it as a separate option may be a bit ugly, as we
> are just talking about code modifications within the setprocattr hook
> function as opposed to a completely new interface and code path, but
> should be possible.  In either case, an error code can be returned by an
> attempt to write to /proc/pid/attr/current; it is just a difference of
> EOPNOTSUPP vs. EACCES.

I guess the question is whether there is any security difference between a 
config option or control over the feature via TE permissions.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
