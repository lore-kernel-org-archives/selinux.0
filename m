From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
Date: Wed, 13 Jun 2007 21:16:01 +1000
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070611204336.GA30846@sergelap.austin.ibm.com> <20070612154412.GC14397@sergelap.austin.ibm.com> <1181663857.17547.227.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1181663857.17547.227.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706132116.05065.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 13 June 2007 01:57, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Well, first, no script should be allowed a capability that is not given
> to its caller directly ;)

Why not?  Isn't that the entire point of this authoritative granting of 
capabilities patch?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
