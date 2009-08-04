Message-ID: <4A7855B5.6080708@kutulu.org>
Date: Tue, 04 Aug 2009 11:37:25 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH v3] libsemanage:  Enable configuration of bzip behavior
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>	 <1249388013.9193.52.camel@moss-pluto.epoch.ncsc.mil>	 <1249389656.9193.73.camel@moss-pluto.epoch.ncsc.mil>	 <1249392325.9193.76.camel@moss-pluto.epoch.ncsc.mil>	 <1249394880.9193.80.camel@moss-pluto.epoch.ncsc.mil> <1249396731.9193.97.camel@moss-pluto.epoch.ncsc.mil> <4A78527D.8000407@redhat.com>
In-Reply-To: <4A78527D.8000407@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/4/2009 11:23 AM, Daniel J Walsh wrote:

> I just want to make sure that if I change the size in semanage.conf, it will still handle all sizes of bzipped files.
> So if we ship xguest.pp.bz2 format it will work.

At compression time, bzip stores the selected block size in the header, 
so the decompression routine knows what to use.  So, yes, it will work fine.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
