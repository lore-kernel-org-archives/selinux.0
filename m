Subject: RE: Attaching multiple user accounts to same home directory...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04BF257F@de01exm68.ds.mot.com>
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <1216209375.17602.77.camel@moss-spartans.epoch.ncsc.mil>
	 <dd18b0c30807160803q7b34551cl567cf9d787db75e8@mail.gmail.com>
	 <1216221492.17602.131.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D04BAFA1E@de01exm68.ds.mot.com>
	 <487F9610.6010104@redhat.com>
	 <D06FE0A2807BC145B0D38744789D4F5D04BAFAC2@de01exm68.ds.mot.com>
	 <487FA2EB.8030608@redhat.com>
	 <D06FE0A2807BC145B0D38744789D4F5D04BF257F@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 08:31:10 -0400
Message-Id: <1216384270.17602.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-17 at 16:01 -0400, Hasan Rezaul-CHR010 wrote:
> Hi Dan,
> 
> Given the project deadline and other constraints, upgrading to the new
> toolchain is NOT an option for me  :-(
> 
> Is there anything else at all I can do as far as tweaking policy or
> config to get by this problem ?  Thanks for your help...

These are just warnings and not fatal errors, so you can ignore them.
If you want to silence them, then you could always patch
libselinux/src/matchpathcon.c to suppress the warning.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
