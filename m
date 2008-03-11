Subject: Re: Semanage return codes...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D046E2705@de01exm68.ds.mot.com>
References: <1205188557.5297.66.camel@localhost.localdomain>
	 <1205248684.23866.137.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D046E2705@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 13:17:40 -0400
Message-Id: <1205255860.23866.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 13:08 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> Have a weird question...
> 
> I run the semanage command inside a script to create/delete user
> mappings as follows:
> 
> -------------------------------------
> semanage login -a -s staff_u Admin
> ret_code = $?
> 
> semanage login -d Admin
> ret_code = $?
> --------------------------------------
> 
> Almost always the return_code is ZERO after the command executes.
> 
> However, I have noticed, sometimes the creation or deletion of the user
> mapping actually "seems" to succeed, BUT the return_code of the semanage
> command is Non-Zero ?!?  I cant understand why ?  Does this make sense ?
> 
> Is there a man page or something out there that shows the various
> possible return/error codes of the semanage command(s) ?

What version of policycoreutils?
Should always exit with status 0 (success) or 1 (error).
Can you provide a specific example of when this has happened to you,
including output?
Are you running other processes simultaneously that are operating on the
policy store?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
