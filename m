Subject: Re: Memory leak question in avc_context_to_sid question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <5C0D2C82-5111-439D-8AAA-5FF17DD415F7@nall.com>
References: <5C0D2C82-5111-439D-8AAA-5FF17DD415F7@nall.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 15:58:26 -0400
Message-ID: <1279915106.32473.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-22 at 16:18 -0500, Joe Nall wrote:
> I have a snippet of code in a bigger class:
> 
>         security_id_t sid = NULL, osid = NULL;
>         if (avc_context_to_sid(*thisContext, &sid) < 0 ||
>             avc_context_to_sid(*otherContext, &osid) < 0)
>             rlog(LOG_ERR, "%s: avc_context_to_sid failed: %m", process_name);
> 
>         struct av_decision avd = {0,0,0,0,0};
>         int astat = avc_has_perm_noaudit(sid, osid, SECCLASS_FILE, FILE__READ, &avcref, &avd);
>         if (astat < 0 && errno != EACCES)
>             rlog(LOG_ERR, "%s: avc_has_perm_noaudit failed: %m", process_name);
> 
>         decision = (avd.allowed & FILE__READ) == FILE__READ;
>         if (sid)
>             sidput(sid);
>         if (osid)
>             sidput(osid);
>         dcache->put(hashKey, decision);
> 
> that valgrind says is leaking memory
> 
> ==3000== 25,470 bytes in 346 blocks are definitely lost in loss record 9 of 9
> ==3000==    at 0x46DFAEE: malloc (vg_replace_malloc.c:207)
> ==3000==    by 0x71670EF: strdup (in /lib/libc-2.9.so)
> ==3000==    by 0x4826E14: (within /lib/libselinux.so.1)
> ==3000==    by 0x4826F66: (within /lib/libselinux.so.1)
> ==3000==    by 0x4824B2A: avc_context_to_sid_raw (in /lib/libselinux.so.1)
> ==3000==    by 0x4824C03: avc_context_to_sid (in /lib/libselinux.so.1)
> ...
> 
> am I missing a cleanup call somewhere? This is a fairly old libselinux (2.0.79-4) on a patched up Fedora 10.

I couldn't seem to reproduce with the current libselinux.  Note however
that reference counted SIDs were dropped in libselinux 2.0.86 (commit
58866dd5668e845fd1cc0f62ae8dd4b93d9caf2b), with avc_cleanup(), sidput(),
and sidget() reduced to no-ops.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
