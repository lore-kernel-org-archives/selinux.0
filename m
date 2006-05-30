Subject: Re: clam/amavis policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200605282225.55326.russell@coker.com.au>
References: <200605282225.55326.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:31:29 -0400
Message-Id: <1149010289.524.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-05-28 at 22:25 +1000, Russell Coker wrote:
> I've attached a patch for the clam/amavis policy against 2.2.40-1.fc5.
> 
> avc:  denied  { write } for  pid=5178 comm="amavisd" name="clamd.sock" 
> dev=dm-0 ino=902623 scontext=root:system_r:amavis_t:s0 
> tcontext=root:object_r:clamd_var_run_t:s0 tclass=sock_file
> 
> I'm getting the above AVC message in spite of the following policy:
> 
> policy/modules/services/clamav.if:
> interface(`clamav_stream_connect',`
>         gen_require(`
>                 type clamd_t, clamd_var_run_t;
>         ')
> 
>         allow $1 clamd_var_run_t:dir search;
>         allow $1 clamd_var_run_t:sock_file write;
>         allow $1 clamd_t:unix_stream_socket connectto;
> ')
> 
> policy/modules/services/amavis.te:
> optional_policy(`
>         clamav_stream_connect(amavis_t)
> ')
> 
> Any advice on what I'm missing would be appreciated.

Not sure how you are building these policies (what is in base, what is
modular), but optionals-in-base support is still not working in
libsepol.  Patch is pending.

Other than that, it would help to see the actual post-processed rules,
and you could run dismod/dispol on the generated module or policy to
dump the actual allow rules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
