Subject: Re: [PATCH] Fix includes for userspace tools and libraries (and
 possible security issue)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1315938784.2218.14.camel@vortex>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 14:48:09 -0400
Message-ID: <1315939689.12522.51.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-09-13 at 20:33 +0200, Guido Trentalancia wrote:
> No, it doesn't currently ! If you want to try reproducing it, then you
> should do so on a system which hasn't got it already installed (or make
> sure you get temporarily rid of
> $(PREFIX)/include/{selinux,sepol,semanage} and
> $(LIBDIR)/lib{selinux,sepol,semanage}.* first).

I know it is presently broken, but not sure exactly when/who broke it.
However, as a working example:
$ git clean -fdx
$ rm -rf ~/out
$ git checkout master@{"16 months ago"}
$ make DESTDIR=~/out

works just fine for me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
