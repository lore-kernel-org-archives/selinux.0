Subject: RE: First Attempt at root login on console always FAILS ??
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0472B4EF@de01exm68.ds.mot.com>
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com>
	 <47D9BBEE.5090105@redhat.com>
	 <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil>
	 <47DA9A3C.3080802@redhat.com>  <47DAD18F.5000309@tycho.nsa.gov>
	 <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com>
	 <1205756531.22912.128.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0472B4EF@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 09:56:17 -0400
Message-Id: <1205848577.6466.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-17 at 18:09 -0400, Hasan Rezaul-CHR010 wrote:
> Hi Stephen & Dan,
> 
> From the /var/log/ files, I am not sure what pam module is having
> problems ?!?  All I get, is a "System error" in the /var/log/secure
> file !
> 
> So I reset the card, when I try to login the first time on the console
> as root, I get "Login incorrect", and the second time, the login is
> successful. This is 100% reproducible.  Selinux is running in
> "Permissive" mode.

This means that one of your pam auth modules failed with a system error.

I'd suggest commenting out some of those pam modules, as I suggested
earlier.  In particular, pam_tally is often a source of problems (and an
easy denial of service).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
