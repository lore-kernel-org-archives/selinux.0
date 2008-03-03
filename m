Subject: Re: mcs translation daemon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <ADD7E44B-3EB0-4DF9-A30D-957C23354ADC@nall.com>
References: <0794F277152EF94AA637E3AECF5CB70F21A367@blums0042.bluelnk.net>
	 <ADD7E44B-3EB0-4DF9-A30D-957C23354ADC@nall.com>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 13:41:08 -0500
Message-Id: <1204569668.23738.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-03 at 12:35 -0600, Joe Nall wrote:
> On Mar 3, 2008, at 10:56 AM, Clarkson, Mike R (US SSA) wrote:
> 
> > How is the mcs translation daemon supposed to be started/restarted?
> 
> run_init

Or, alternately, build policy with DIRECT_INITRC=y.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
