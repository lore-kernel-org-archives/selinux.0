Date: Wed, 28 Jan 2009 08:54:51 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Berger Timothy-TBERGER1 <T.Berger@motorola.com>,
        Stephens Brad-CBS056 <Brad.Stephens@motorola.com>
Subject: Re: Enabling the "noatime" option on filesystems...
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D052F7BE3@de01exm68.ds.mot.com>
Message-ID: <alpine.LRH.1.10.0901280854340.11866@tundra.namei.org>
References: <alpine.LFD.2.00.0901271229120.11868@home-av-server.home-av> <497F641E.9050500@hp.com> <D06FE0A2807BC145B0D38744789D4F5D052F7BE3@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jan 2009, Hasan Rezaul-CHR010 wrote:

> Hi All,
> 
> If I enable the 'noatime' option on all my mounted filesystems, such
> that anytime a given file is accessed for "READ", the last access time
> is not updated: will this cause any negative impacts to SELinux ?
> 
> I am guessing it does NOT, but just wanted to make sure if there are any
> impacts... Thanks,

It should have no effect.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
