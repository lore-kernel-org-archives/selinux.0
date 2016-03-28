Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SFfdaE008807
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 11:41:39 -0400
Date: Mon, 28 Mar 2016 11:41:30 -0400 (EDT)
Message-Id: <20160328.114130.2069088439489149203.davem@davemloft.net>
To: paul@paul-moore.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, Janak.Desai@gtri.gatech.edu,
 pmoore@redhat.com
Subject: Re: [PATCH] netlabel: fix a problem with
 netlbl_secattr_catmap_setrng()
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhTV_0tdRgFEcRoF1qjBunjwK6rSp8wpB4Jqjow2ENToCg@mail.gmail.com>
References: <145917783800.9565.7759086668991534988.stgit@localhost>
 <CAHC9VhTV_0tdRgFEcRoF1qjBunjwK6rSp8wpB4Jqjow2ENToCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Mar 2016 11:17:28 -0400

> On Mon, Mar 28, 2016 at 11:10 AM, Paul Moore <pmoore@redhat.com> wrote:
>> From: Janak Desai <Janak.Desai@gtri.gatech.edu>
>>
>> We try to be clever and set large chunks of the bitmap at once, when
>> possible; unfortunately we weren't very clever when we wrote the code
>> and messed up the if-conditional.  Fix this bug and restore proper
>> operation.
>>
>> Signed-off-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  net/netlabel/netlabel_kapi.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> DaveM, I'm planning on carrying this in selinux#next unless you really
> want to this to go to Linus via the netdev tree.

I'm fine with it going via your tree, thanks.
