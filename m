From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162313484.32614.104.camel@moss-spartans.epoch.ncsc.mil> 
References: <1162313484.32614.104.camel@moss-spartans.epoch.ncsc.mil>  <1161972628.1306.140.camel@moss-spartans.epoch.ncsc.mil> <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil> <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil> <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <27450.1161960110@redhat.com> <5318.1161965576@redhat.com> <7319.1161970091@redhat.com> <25910.1162311558@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Tue, 31 Oct 2006 19:21:18 +0000
Message-ID: <28829.1162322478@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> To define the type, you would need a policy module.

Karl MacMillan gave me such a beast, and now I have cachefilesd running in the
cachefilesd_t context:

user_u:system_r:cachefilesd_t:s0 5019 ?        Ss     0:00 cachefilesd

With permission to access the cachefiles_t context (in which /var/fscache
resides).

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
