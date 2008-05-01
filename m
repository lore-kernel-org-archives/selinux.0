Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m41EkooX024893
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2008 10:46:50 -0400
Received: from qb-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m41Ekm8U025175
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2008 14:46:49 GMT
Received: by qb-out-0506.google.com with SMTP id e7so1167775qbe.8
        for <selinux@tycho.nsa.gov>; Thu, 01 May 2008 07:46:48 -0700 (PDT)
Message-ID: <7e0fb38c0805010746r4e43b640h1eee1b542763b022@mail.gmail.com>
Date: Thu, 1 May 2008 10:46:47 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH v2] selinux: support deferred mapping of contexts
Cc: "James Morris" <jmorris@namei.org>, selinux@tycho.nsa.gov,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <1209642084.25678.418.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
	 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
	 <1209642084.25678.418.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 1, 2008 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>
>  On Thu, 2008-05-01 at 07:04 -0400, Stephen Smalley wrote:
>  > On Thu, 2008-05-01 at 09:06 +1000, James Morris wrote:
>  > > On Wed, 30 Apr 2008, Stephen Smalley wrote:
>  > >
>  > > > As discussed in:
>  > > > http://marc.info/?t=120837952900003&r=1&w=2
>  > > > the ability to permit package managers and similar programs to set down
>  > > > unknown file contexts is still desired/required, not only for putting
>  > > > policy modules in packages but also for enabling build systems to create
>  > > > images of different distro releases with different policies w/o
>  > > > requiring all of the types to be defined in the build host policy.
>  > > >
>  > >
>  > > Does this solve all known issues for this case?  e.g. what if a script
>  > > needs to be run by RPM on a file it just created ?  Does that ever happen?
>  >
>  > If required, I believe that can be addressed by allowing rpm_script_t
>  > the ability to execute (along with create, read, and write) an
>  > unlabeled_t file.  And note that this only happens when the file's type
>  > is only defined by the policy module within the package itself (for
>  > policy-modules-in-packages) or when the file's type is not defined by
>  > the build host's policy (for buildsys), whereas the most common
>  > executable types are all defined in the base policy and will typically
>  > be present in the build host policy as well.
>  >
>  > It isn't a perfectly general solution, of course.
>  >
>  > An alternative approach would be for rpm to load policy at least
>  > defining the types first before setting down the files, which was our
>  > original preference, but that wasn't viewed as workable by the distro
>  > folks.  It might be easier if we had a specific SELinux kernel interface
>  > (i.e. another selinuxfs node) that permitted adding types w/o performing
>  > a complete policy reload.
>
>  ...except that adding new types affects attributes, and attribute
>  expansion still happens in part in userspace (e.g. for file_type
>  -shadow_t expressions), and attributes aren't preserved in the kernel's
>  types symtab.  So it isn't straightforward to support such direct
>  additions at the kernel interface presently.

In the case of adding types merely for the purposes of having them
defined but not including any allow rules around them I don't see this
an issue.  Is there a problem with 'lightweight' types which you can
push in via some new mechanism but which are basically useless for
anything other than validation of existence?  If you want a real type
with allow rules you have to load it in a real policy load?

Just not sure attribute expansion has to stop this line of thought.
Although the original patch does seem to solve all the problems in a
manor that requires a lot less changes everywhere else.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
