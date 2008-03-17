Date: Tue, 18 Mar 2008 10:02:17 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
Subject: Re: [patch] selinux:  handle files opened with flags 3 by checking
 ioctl permission
In-Reply-To: <1205792367.2891.1.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0803181000390.18000@us.intercode.com.au>
References: <1205349239.2925.11.camel@localhost.localdomain>
 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
 <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0803170840430.24928@us.intercode.com.au>
 <1205758518.22912.154.camel@moss-spartans.epoch.ncsc.mil>
 <1205764248.4169.0.camel@localhost.localdomain>
 <Xine.LNX.4.64.0803180915000.25060@us.intercode.com.au>
 <1205792367.2891.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Mar 2008, Eric Paris wrote:

> > Fixes the problem I was seeing.  Applied to for-akpm.
> 
> Are you at least now seeing a FILE__IOCTL avc for mdadm?  If not why
> would mdadm have that permission for /dev/null?

kernel: [ 4.779280] type=1400 audit(1205792724.308:4): avc:  granted null 
for pid=1792 comm="mdadm" name="null" dev=tmpfs ino=189 
scontext=system_u:system_r:mdadm_t:s0 
tcontext=system_u:object_r:null_device_t:s0 tclass=chr_file

Possibly related.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
