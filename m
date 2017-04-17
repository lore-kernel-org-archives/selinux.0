Message-ID: <1492436089.12012.3.camel@tycho.nsa.gov>
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
From: Stephen Smalley <sds@tycho.nsa.gov>
To: dwalsh@redhat.com, Nicolas Iooss <nicolas.iooss@m4x.org>, selinux
 <selinux@tycho.nsa.gov>, Dominick Grift <dac.override@gmail.com>
Date: Mon, 17 Apr 2017 09:34:49 -0400
In-Reply-To: <2844f689-2726-886f-f824-35723ef57742@redhat.com>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov> <20170414184946.GB16153@markus>
 <CAJfZ7==rsOexenE+76YX0fbgX9_eXGjygmNzaHL1G8azKk8EMw@mail.gmail.com>
 <1492202486.26072.8.camel@tycho.nsa.gov>
 <2844f689-2726-886f-f824-35723ef57742@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-04-15 at 06:23 -0400, Daniel Walsh wrote:
> I believe that libselinux still reports that the system is running
> with
> SELinux, if the selinuxfs is not mounted
> inside of the container at all.

Not after the commit referenced in the subject line; you removed the
fallback code to check /proc/filesystems for selinuxfs from
is_selinux_enabled(), so if selinuxfs is not mounted at all, it will
return 0 (not enabled).  On non-Android, you can also cause
is_selinux_enabled() to return 0 by not providing an
/etc/selinux/config file in your container's root directory (see commit
 
c08c4eacab8d55598b9e5caaef8a871a7a476cab), i.e. as long as you do not
install selinux-policy in your container root, then it will return
disabled.
