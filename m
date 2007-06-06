From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
Date: Wed, 6 Jun 2007 19:01:59 +1000
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Alan Cox <alan@redhat.com>, drepper@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        jmorris@namei.org, chrisw@redhat.com, sds@tycho.nsa.gov,
        sgrubb@redhat.com
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com> <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil> <1181075666.3978.31.camel@localhost.localdomain>
In-Reply-To: <1181075666.3978.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706061902.05786.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 06 June 2007 06:34, Eric Paris <eparis@redhat.com> wrote:
> This patch uses a new SELinux security class "memprotect."  Policy
> already contains a number of allow rules like  a_t self:process *
> (unconfined_t being one of them) which mean that putting this check in
> the process class (its best current fit) would make it useless as all

I think it would be best to use the process class and change the "*" rules to 
~{ memprotect }.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
