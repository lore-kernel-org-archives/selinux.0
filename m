Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02610
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 15:00:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA25763
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:59:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA25759
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:59:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Squid policy for SE Linux
Date: Wed, 6 Mar 2002 21:00:22 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>, <miquels@cistron.nl>
References: <Pine.GSO.4.33.0203061158000.24985-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203061158000.24985-100000@raven>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M8IKMHXIMJQR13FIXW7F"
Message-Id: <20020306200023.32F211F08B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_M8IKMHXIMJQR13FIXW7F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Wed, 6 Mar 2002 18:24, Stephen Smalley wrote:
> > Here's the relevant parts of my file_contexts file:
> > /var/cache/squid(|/.*)          system_u:object_r:httpd_cache_t
>
> I'm unclear as to whether it is a good idea to use the same type here as
> for /var/cache/httpd.  Do you really want to grant squid and httpd the
> same set of accesses to both /var/cache/httpd and /var/cache/squid?

Firstly I doubt that anyone would use both apache and Squid to act as web 
caches.  So it made sense to me at the time.

Now I think it should be squid_cache_t instead.

> > /usr/lib/squid                  system_u:object_r:squid_t
>
> In a TE policy, you typically keep the domain space and the object type
> space separate - i.e. you never use a domain as a file type.  In SELinux,
> there is a special case for the /proc/PID entries of a process, which are
> labeled with the SID of the process (and hence its domain).  If you use
> the domain for other files, the policy won't be able to distinguish
> between the /proc/PID entries and these other files.  So I would recommend
> using a different type here, possibly just leaving it in lib_t unless you
> truly need to separate it.

OK.  I'll change it to lib_t then.

> > I also added squid_t to system_r in the rbac file.
>
> I've partitioned the role declarations up among the various .te files in
> our internal copy of the policy, so this will actually be moved into
> squid.te.

Great!  It was becoming difficult to manage with everything in the rbac file.

> My comments on your squid.te file are below:
> ># squid_t is the domain the squid process runs in, and is also the SID
> >for
> ># files in /usr/lib/squid
> >type squid_t, domain, privlog;
>
> As I mentioned above, I wouldn't recommend using this domain as a file
> type.  Also, since you didn't include the file_type attribute, the kernel
> should have denied your attempt to relabel the file to this domain, unless
> you were running in permissive mode at the time.  In contrast, the kernel
> is free to apply the domain to pseudo files that it generates like
> /proc/PID.

I am running in permissive mode.  I haven't got enough policy written to be 
confident that my machine can keep operating in enforcing mode.  Also the 
problems previously discussed regarding devfs and tty permissions is a 
serious roadblock for me.

> ># httpd_cache_t is for /var/cache/squid
> >allow squid_t httpd_cache_t:dir create_dir_perms;
> >allow squid_t httpd_cache_t:file rw_file_perms;
> >file_type_auto_trans(squid_t, httpd_cache_t, httpd_cache_t)
>
> As I also mentioned above, I'm not sure if you want to use the same type
> that is being used for /var/cache/httpd.  Make sure that there aren't any
> implications of granting both squid and httpd the same set of permissions
> to both sets of files.

Yes, that is something I hadn't thought through.  While we only have one of 
these programs active on a typical system there is the potential that someone 
could use a squid bug to attach Apache (or the other way around).

> >allow squid_t var_log_squid_t:dir rw_dir_perms;
> >allow squid_t var_log_squid_t:file rw_file_perms;
> >file_type_auto_trans(squid_t, var_log_squid_t, var_log_squid_t)
>
> You only need a file_type_auto_trans rule if you want the new file to
> inherit a type other than the type of the parent directory.  If
> /var/log/squid were a file or directory that was created (or recreated) at
> runtime by squid, then you would need a rule like
> 	file_type_auto_trans(squid_t, var_log_t, var_log_squid_t)
> to ensure that it was created with the right type.  But if /var/log/squid
> is always created during installation and you initially label it with
> the type, then all files created within it will inherit that type
> automatically without needing the file_type_auto_trans rule.

That part is clear from the example policy you wrote.

However in this instance /var/log/squid is a directory containing files that 
are created by Squid.  So I think that my policy above is what is required 
(at least it seems to work OK).

> ># for /usr/lib/squid
> >allow squid_t squid_t:dir r_dir_perms;
> >allow squid_t squid_t:file r_file_perms;
> >allow squid_t squid_t:file { execute_no_trans execute };
>
> As mentioned above, I'd suggest using a different type for /usr/lib/squid,
> possibly leaving it in lib_t.  For the execute-related permissions, I'd
> suggest using can_exec(squid_t, lib_t) or whatever your type is.

OK.

> >allow squid_t squid_exec_t:file execute_no_trans;
>
> I'm not clear as to why this is needed, unless squid re-executes itself at
> times.

It appears to do that.  I'm not sure why, maybe Mike can shed some light.

> The domain_auto_trans rule handles giving permissions to initially
> enter the domain via this executable.  In any case, I'd suggest using the
> can_exec macro, e.g.
> 	can_exec(squid_t, squid_exec_t)

OK.

I've attached my latest squid.te file with changes as per your suggestions.

Also I think that we should review the port types, I think that having a 
sample policy of ports 8080 and 80 having the same type is a bad idea.  80 is 
the standard web serving port (with some minor use by web caches), 8080 is 
the non-standard but most common port for web caches (but almost never web 
serving).  It would make sense to have a different port type for 8080, allow 
both Apache and Squid to use 8080, but allow Squid only 8080 and other cache 
ports.

Squid also commonly uses TCP port 3128 (instead of 8080), and UDP port 3130.  
Squid is written to support TCP port 4827 for cache digests and it would 
probably be best if this is included in sample policy even though most people 
don't use it.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_M8IKMHXIMJQR13FIXW7F
Content-Type: text/plain;
  charset="iso-8859-1";
  name="squid.te"
Content-Transfer-Encoding: base64
Content-Description: squid.te
Content-Disposition: attachment; filename="squid.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgc3F1aWRfdCBk
b21haW4uCiMKIyBzcXVpZF90IGlzIHRoZSBkb21haW4gdGhlIHNxdWlkIHByb2Nlc3MgcnVucyBp
bgp0eXBlIHNxdWlkX3QsIGRvbWFpbiwgcHJpdmxvZzsKCiMgdmFyX2xvZ19zcXVpZF90IGlzIGZv
ciAvdmFyL2xvZy9zcXVpZAp0eXBlIHZhcl9sb2dfc3F1aWRfdCwgZmlsZV90eXBlLCBzeXNhZG1m
aWxlOwoKIyBtYWluIHNxdWlkIGJpbmFyeSBpcyBvZiBzcXVpZF9leGVjX3QKdHlwZSBzcXVpZF9l
eGVjX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwoKIyB0eXBlIGZvciAvdmFy
L2NhY2hlL3NxdWlkCnR5cGUgc3F1aWRfY2FjaGVfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwoK
IyBJbmhlcml0IGFuZCB1c2UgZGVzY3JpcHRvcnMgZnJvbSBpbml0LgphbGxvdyBzcXVpZF90IGlu
aXRfdDpmZCBpbmhlcml0X2ZkX3Blcm1zOwoKIyBDcmVhdGUgcGlkIGZpbGUuCnR5cGUgc3F1aWRf
dmFyX3J1bl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIHBpZGZpbGU7CmZpbGVfdHlwZV9hdXRv
X3RyYW5zKHNxdWlkX3QsIHZhcl9ydW5fdCwgc3F1aWRfdmFyX3J1bl90KQoKIyBzcXVpZF9jYWNo
ZV90IGlzIGZvciAvdmFyL2NhY2hlL3NxdWlkCmFsbG93IHNxdWlkX3Qgc3F1aWRfY2FjaGVfdDpk
aXIgY3JlYXRlX2Rpcl9wZXJtczsKYWxsb3cgc3F1aWRfdCBzcXVpZF9jYWNoZV90OmZpbGUgcndf
ZmlsZV9wZXJtczsKZmlsZV90eXBlX2F1dG9fdHJhbnMoc3F1aWRfdCwgc3F1aWRfY2FjaGVfdCwg
c3F1aWRfY2FjaGVfdCkKCmFsbG93IHNxdWlkX3QgdmFyX2xvZ19zcXVpZF90OmRpciByd19kaXJf
cGVybXM7CmFsbG93IHNxdWlkX3QgdmFyX2xvZ19zcXVpZF90OmZpbGUgcndfZmlsZV9wZXJtczsK
ZmlsZV90eXBlX2F1dG9fdHJhbnMoc3F1aWRfdCwgdmFyX2xvZ19zcXVpZF90LCB2YXJfbG9nX3Nx
dWlkX3QpCgojIGZvciAvdXNyL2xpYi9zcXVpZAphbGxvdyBzcXVpZF90IHNxdWlkX3Q6ZGlyIHJf
ZGlyX3Blcm1zOwphbGxvdyBzcXVpZF90IHNxdWlkX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CgpjYW5f
bmV0d29yayhzcXVpZF90KQojIHBvcnQgODA4MCBpcyBodHRwX3BvcnQKYWxsb3cgc3F1aWRfdCBo
dHRwX3BvcnRfdDp0Y3Bfc29ja2V0IG5hbWVfYmluZDsKYWxsb3cgc3F1aWRfdCBzcXVpZF90OmZp
bGUgeyBleGVjdXRlX25vX3RyYW5zIGV4ZWN1dGUgfTsKYWxsb3cgc3F1aWRfdCBzcXVpZF9leGVj
X3Q6ZmlsZSBleGVjdXRlX25vX3RyYW5zOwoKZG9tYWluX2F1dG9fdHJhbnMoaW5pdHJjX3QsIHNx
dWlkX2V4ZWNfdCwgc3F1aWRfdCkKCiMgdG8gYWxsb3cgcnVubmluZyBwcm9ncmFtcyBmcm9tIC91
c3IvbGliL3NxdWlkIChJRSB1bmxpbmtkKQojIGFsc28gYWxsb3cgZXhlYygpaW5nIGl0c2VsZgpj
YW5fZXhlYyhzcXVpZF90LCB7IGxpYl90IHNxdWlkX2V4ZWNfdCB9ICkK

--------------Boundary-00=_M8IKMHXIMJQR13FIXW7F--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
