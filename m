Subject: Re: libselinux.so: cannot open shared object file
From: Colin Walters <walters@verbum.org>
To: max barwell <maxb@paradise.net.nz>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1062637188.565.7.camel@orac.lite.net.nz>
References: <1062637188.565.7.camel@orac.lite.net.nz>
Content-Type: text/plain
Message-Id: <1062690102.15712.16.camel@columbia>
Mime-Version: 1.0
Date: Thu, 04 Sep 2003 11:41:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-03 at 20:59, max barwell wrote:
> I am using debian sid, I compiled a 2.6.0-test4 kernel ready for use,
> and downloaded Colin Walters SElinux packages, during their install, and
> I'm not sure when as I wasn't watching, the install borked, and now when
> I try to do anything ie type ls, I get the error message
> 
> error while loading shared libraries: libselinux.so: cannot open shared
> object file: No such file or directory 

Hm, for some reason the binaries are getting linked against
libselinux.so instead of libselinux.so.1.  I'll investigate this.  In
the meantime it should be sufficient to install libselinux1-dev. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
