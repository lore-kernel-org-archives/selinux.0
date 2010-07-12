From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwintorok@gmail.com>
Subject: Re: clamav RWX
Date: Tue, 13 Jul 2010 07:32:21 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <201007121922.48247.russell@coker.com.au> <1278952271.5221.245.camel@moss-pluto.epoch.ncsc.mil> <20100712210807.675e6e0e@debian>
In-Reply-To: <20100712210807.675e6e0e@debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201007130732.21786.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jul 2010, Török Edwin <edwintorok@gmail.com> wrote:
> So if I map a tempfile as RW, write my JITed code to it, then mprotect
> to RX will it work without 'execmem'?

In this case I think that there are two viable options.  One is to prevent 
execmem for both freshclam_t and clamd_t and have them both interpret the 
data, a performance cost for a security benefit.  The other is to allow them 
both execmem access for best performance.  I have already submitted a patch to 
the policy list to implement this.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
