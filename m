Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA08152
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 07:19:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA20558
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 12:18:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA20548 for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 12:18:27 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 759C492674
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 23:19:14 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id AC8E4286E3
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 13:19:02 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: devfs permissions
Date: Sun, 24 Feb 2002 05:02:19 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_V7R0KKZXQXPO3XE6AXHD"
Message-Id: <20020224121902.AC8E4286E3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_V7R0KKZXQXPO3XE6AXHD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've been thinking about devfs permissions some more.

My initial idea was to totally replace the current kernel code with code in 
devfsd, however of course that raises the issue of what permissions to use to 
get the system far enough into the boot process to execute devfsd.

One potential solution to this is to make all devfs nodes have a default SID, 
and have the policy allow init_t and initrc_t programs full read-write access 
and devfs_t programs to change SID.  Though this seems to be moving the 
uglyness from device node creation to policy.

Another potential solution is to keep the current method of assigning SIDs to 
devfs nodes, but use it only for the early stages of boot after which devfsd 
takes over.

In either case we need to have devfsd manage SIDs on devfs nodes, currently 
/dev/initctl and /dev/log don't get assigned a SID on devfs (also other pipes 
and sockets would have the same problem - but aren't as important and don't 
fail as spectacularly).

For interest I have attached the latest devfs_contexts file I am using.  I 
have attempted to make it give the same result as the file_contexts entries 
for non-devfs systems as much as possible (but as it doesn't do regular 
expressions it's impossible to distinguish between CDs and hard drives).

At the moment if you want full functionality on an SE system with devfs you 
will have to write an init script that runs suitable chsid commands.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--------------Boundary-00=_V7R0KKZXQXPO3XE6AXHD
Content-Type: text/plain;
  charset="us-ascii";
  name="devfs_contexts"
Content-Transfer-Encoding: base64
Content-Description: devfs_contexts
Content-Disposition: attachment; filename="devfs_contexts"

IyBGTEFTSwoKIwojIFNlY3VyaXR5IGNvbnRleHRzIGZvciBkZXZmcyBlbnRyaWVzLgojCiMgRWFj
aCBzcGVjaWZpY2F0aW9ucyBoYXMgdGhlIGZvcm06CiMgCXBhdGhuYW1lLXByZWZpeCBbIC10eXBl
IF0gY29udGV4dAojCiMgVGhlIGVudHJ5IHdpdGggdGhlIGxvbmdlc3QgbWF0Y2hpbmcgcGF0aG5h
bWUgcHJlZml4IGlzIHVzZWQuCiMgLyByZWZlcnMgdG8gdGhlIHJvb3QgZGlyZWN0b3J5IG9mIHRo
ZSBkZXZmcyBmaWxlIHN5c3RlbSwgYW5kCiMgZXZlcnl0aGluZyBpcyBzcGVjaWZpZWQgcmVsYXRp
dmUgdG8gdGhpcyByb290IGRpcmVjdG9yeS4KIyBJZiB0aGVyZSBpcyBubyBlbnRyeSB3aXRoIGEg
bWF0Y2hpbmcgcGF0aG5hbWUgcHJlZml4LCB0aGVuIAojIHRoZSBkZXZmcyBpbml0aWFsIFNJRCBp
cyB1c2VkLgojCiMgVGhlIG9wdGlvbmFsIHR5cGUgZmllbGQgc3BlY2lmaWVzIHRoZSBmaWxlIHR5
cGUgYXMgc2hvd24gaW4gdGhlIG1vZGUKIyBmaWVsZCBieSBscywgZS5nLiB1c2UgLWMgdG8gbWF0
Y2ggb25seSBjaGFyYWN0ZXIgZGV2aWNlIGZpbGVzLCAtYgojIHRvIG1hdGNoIG9ubHkgYmxvY2sg
ZGV2aWNlIGZpbGVzLgojCgovCQkJc3lzdGVtX3U6b2JqZWN0X3I6ZGV2ZnNfdAovbnVsbAkJCXN5
c3RlbV91Om9iamVjdF9yOm51bGxfZGV2aWNlX3QKL3plcm8JCQlzeXN0ZW1fdTpvYmplY3Rfcjp6
ZXJvX2RldmljZV90Ci9jb25zb2xlCQlzeXN0ZW1fdTpvYmplY3Rfcjpjb25zb2xlX2RldmljZV90
Ci9rbWVtCQkJc3lzdGVtX3U6b2JqZWN0X3I6bWVtb3J5X2RldmljZV90Ci9tZW0JCQlzeXN0ZW1f
dTpvYmplY3RfcjptZW1vcnlfZGV2aWNlX3QKL3BvcnQJCQlzeXN0ZW1fdTpvYmplY3RfcjptZW1v
cnlfZGV2aWNlX3QKL3JhbmRvbQkJCXN5c3RlbV91Om9iamVjdF9yOnJhbmRvbV9kZXZpY2VfdAov
dXJhbmRvbQkJc3lzdGVtX3U6b2JqZWN0X3I6cmFuZG9tX2RldmljZV90Ci90dHkJCQlzeXN0ZW1f
dTpvYmplY3RfcjpkZXZ0dHlfdAovdmMgLWMJCQlzeXN0ZW1fdTpvYmplY3Rfcjp0dHlfZGV2aWNl
X3QKL3B0cwkJCXN5c3RlbV91Om9iamVjdF9yOmRldnB0c190Ci9zY3NpCS1jCQlzeXN0ZW1fdTpv
YmplY3RfcjpmaXhlZF9kaXNrX2RldmljZV90Ci9zY3NpCS1iCQlzeXN0ZW1fdTpvYmplY3Rfcjpm
aXhlZF9kaXNrX2RldmljZV90Ci9pZGUJLWMJCXN5c3RlbV91Om9iamVjdF9yOmZpeGVkX2Rpc2tf
ZGV2aWNlX3QKL2lkZQktYgkJc3lzdGVtX3U6b2JqZWN0X3I6Zml4ZWRfZGlza19kZXZpY2VfdAov
ZGlzY3MJLWMJCXN5c3RlbV91Om9iamVjdF9yOmZpeGVkX2Rpc2tfZGV2aWNlX3QKL2Rpc2NzCS1i
CQlzeXN0ZW1fdTpvYmplY3RfcjpmaXhlZF9kaXNrX2RldmljZV90Ci9jZHJvbXMJLWMJCXN5c3Rl
bV91Om9iamVjdF9yOnJlbW92YWJsZV9kZXZpY2VfdAovY2Ryb21zCS1iCQlzeXN0ZW1fdTpvYmpl
Y3RfcjpyZW1vdmFibGVfZGV2aWNlX3QKL2Zsb3BweQktYwkJc3lzdGVtX3U6b2JqZWN0X3I6cmVt
b3ZhYmxlX2RldmljZV90Ci9mbG9wcHkJLWIJCXN5c3RlbV91Om9iamVjdF9yOnJlbW92YWJsZV9k
ZXZpY2VfdAovcnRjCQkJc3lzdGVtX3U6b2JqZWN0X3I6Y2xvY2tfZGV2aWNlX3QKL3BwcAkJCXN5
c3RlbV91Om9iamVjdF9yOm5ldF9kZXZpY2VfdAovaW5pdGN0bAkJc3lzdGVtX3U6b2JqZWN0X3I6
aW5pdGN0bF90Ci9sb2cJCQlzeXN0ZW1fdTpvYmplY3RfcjpkZXZsb2dfdAovbWlzYy9wc2F1eAkJ
c3lzdGVtX3U6b2JqZWN0X3I6bW91c2VfZGV2aWNlX3QKL2lucHV0L21vdXNlCQlzeXN0ZW1fdTpv
YmplY3Rfcjptb3VzZV9kZXZpY2VfdAovZ3BtY3RsCQkJc3lzdGVtX3U6b2JqZWN0X3I6Z3BtY3Rs
X3QKL3B0bXgJCQlzeXN0ZW1fdTpvYmplY3RfcjpwdG14X3QKL21pc2MvYXBtX2Jpb3MJCXN5c3Rl
bV91Om9iamVjdF9yOmFwbV9iaW9zX3QKL3NvdW5kIC1jCQlzeXN0ZW1fdTpvYmplY3Rfcjpzb3Vu
ZF9kZXZpY2VfdAoKIyBGTEFTSwo=

--------------Boundary-00=_V7R0KKZXQXPO3XE6AXHD--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
