From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [redhat-lspp] pam_namespace is broken from an SELinux perspective.
Date: Fri, 8 Dec 2006 06:34:18 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
References: <4576E34D.1030105@hp.com> <45783EA8.5080701@redhat.com> <1165513002.12263.69.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1165513002.12263.69.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612080634.23288.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 December 2006 04:36, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> You could work around it by labeling the top-level directories like /tmp
> and /home/dwalsh with other types (e.g. poly_tmp_t, poly_home_t)
> distinct for polyinstantiated directories, and then define type_member
> rules on those, e.g. type_member staff_t poly_tmp_t:dir tmp_t;
> type_member staff_t poly_home_t:dir staff_home_dir_t;

The problem with this is that it makes installation of poly-instantiated 
directories more difficult.

I would like to see the installation process be as easy as possible to 
encourage people who aren't the most capable sys-admins to do it.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
