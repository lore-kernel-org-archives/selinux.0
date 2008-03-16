Date: Mon, 17 Mar 2008 08:41:27 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, Eric Paris <eparis@redhat.com>,
        selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
Subject: Re: How to handle security_dentry_open when the open flags are
 'special'
In-Reply-To: <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0803170840430.24928@us.intercode.com.au>
References: <1205349239.2925.11.camel@localhost.localdomain>
 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
 <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Mar 2008, Stephen Smalley wrote:

> Alternatively, we could default to returning FILE__IOCTL from
> file_to_av() if the f_mode has neither FMODE_READ nor FMODE_WRITE, and
> thus check ioctl permission on exec or transfer, thereby validating such
> descriptors early as with normal r/w descriptors and catching leaks of
> them prior to attempted usage.

I think this sounds like a good plan.

> 
> selinux_dentry_open() though doesn't need to check anything in this
> case; its checking is only required for descriptors that can later be
> used in read/write operations.
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
