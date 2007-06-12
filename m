From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
Date: Tue, 12 Jun 2007 19:20:03 +1000
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070611204336.GA30846@sergelap.austin.ibm.com> <620792.60154.qm@web36608.mail.mud.yahoo.com> <20070611222402.GA21593@sergelap.austin.ibm.com>
In-Reply-To: <20070611222402.GA21593@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706121920.07268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 June 2007 08:24, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> That changes how one uses these a bit, in an interesting way.  Let's say
> we want users running ping to get CAP_NET_RAW.  If ping were then
> exploited to exec something else, then with capabilities it would lose
> CAP_NET_RAW.  How should (or should?) that be emulated in selinux?

The solution to this example is to not allow ping to execute anything - it has 
no need to do so anyway.  Also an attacker who exploited ping could probably 
make it do whatever net-raw operations they desired without needing to 
execute a different program.

For the general case of a privileged process executing another process you 
want a domain_auto_trans.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
