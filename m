From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "A Almeida" <skubey@hotmail.com>, SELinux@tycho.nsa.gov
Subject: Re: postmaster/postgres policy files
Date: Fri, 2 Aug 2002 20:20:02 +0200
References: <F88TF4ia5wAz8AWiZAt0001366f@hotmail.com>
In-Reply-To: <F88TF4ia5wAz8AWiZAt0001366f@hotmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EXA8ZMBUV3WEL3AFMGDC"
Message-Id: <20020802182002.B4728164@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_EXA8ZMBUV3WEL3AFMGDC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Fri, 2 Aug 2002 17:50, A Almeida wrote:
> Since the message quoted below was posted in February, has anyone written
> policy files for postgres/postmaster that you'd be willing to share?

Yes, attached to this message.  It's not finished, but it's probably easier 
than starting from nothing.  Also you'll have to change your postgresql start 
scripts to not call su.

> If not, the thing to do seems to make a new label for the executable
> postmaster (which is a symlink to postgres).  It should be labelled
> something like system_u:object_r:postgres_t instead of
> system_u:object_r:bin_t.  Then, a TE file defining policy and transitioning
> initrc_t to postgres_t would be needed.

Yes, use daemon_domain() for this.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_EXA8ZMBUV3WEL3AFMGDC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="postgresql.fc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="postgresql.fc"

IyBwb3N0Z3Jlc3FsIC0gbGRhcCBzZXJ2ZXIKL3Vzci9saWIvcG9zdGdyZXNxbC9iaW4vLioJc3lz
dGVtX3U6b2JqZWN0X3I6cG9zdGdyZXNxbF9leGVjX3QKL3Zhci9saWIvcG9zdGdyZXMofC8uKikJ
CXN5c3RlbV91Om9iamVjdF9yOnBvc3RncmVzcWxfZGJfdAovdmFyL3J1bi9wb3N0Z3Jlc3FsKHwv
LiopCXN5c3RlbV91Om9iamVjdF9yOnZhcl9ydW5fcG9zdGdyZXNxbF90Ci9ldGMvcG9zdGdyZXNx
bCh8Ly4qKQkJc3lzdGVtX3U6b2JqZWN0X3I6ZXRjX3Bvc3RncmVzcWxfdAovdmFyL2xvZy9wb3N0
Z3Jlcy5sb2cuKgkJc3lzdGVtX3U6b2JqZWN0X3I6cG9zdGdyZXNxbF9sb2dfdAo=

--------------Boundary-00=_EXA8ZMBUV3WEL3AFMGDC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="postgresql.te"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="postgresql.te"

IwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1c3NlbGxAY29rZXIuY29tLmF1PgojCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIwojIFJ1bGVzIGZvciB0aGUgcG9zdGdyZXNx
bF90IGRvbWFpbi4KIwojIHBvc3RncmVzcWxfZXhlY190IGlzIHRoZSB0eXBlIG9mIHRoZSBwb3N0
Z3Jlc3FsIGV4ZWN1dGFibGUuCiMKZGFlbW9uX2RvbWFpbihwb3N0Z3Jlc3FsKQoKIyBncm9zcyBo
YWNrCmRvbWFpbl9hdXRvX3RyYW5zKGRwa2dfdCwgcG9zdGdyZXNxbF9leGVjX3QsIHBvc3RncmVz
cWxfdCkKIyBhIGdyb3NzZXIgaGFjawphbGxvdyBwb3N0Z3Jlc3FsX3QgZXRjX3Q6ZmlsZSBzZXRh
dHRyOwoKYXVkaXRkZW55IHBvc3RncmVzcWxfdCB7IHN5c2FkbV9ob21lX3QgdmFyX3Nwb29sX3Qg
fTpkaXIgfnNlYXJjaDsKCmFsbG93IHBvc3RncmVzcWxfdCBzZWxmOmNhcGFiaWxpdHkgeyBkYWNf
b3ZlcnJpZGUgZGFjX3JlYWRfc2VhcmNoIGNob3duIGZvd25lciBmc2V0aWQgc2V0dWlkIHNldGdp
ZCB9OwoKdHlwZSBldGNfcG9zdGdyZXNxbF90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUg
cG9zdGdyZXNxbF9kYl90LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7CnR5cGUgcG9zdGdyZXNxbF9s
b2dfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOwoKZmlsZV90eXBlX2F1dG9fdHJhbnMocG9zdGdy
ZXNxbF90LCB2YXJfbG9nX3QsIHBvc3RncmVzcWxfbG9nX3QpCgphbGxvdyBwb3N0Z3Jlc3FsX3Qg
c3lzdGVtX2Nyb25kX3NjcmlwdF90OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKCnRtcF9kb21haW4o
cG9zdGdyZXNxbCk7CmNhbl9leGVjKHBvc3RncmVzcWxfdCwgZHBrZ19leGVjX3QpCgojIFVzZSB0
aGUgbmV0d29yay4KY2FuX25ldHdvcmsocG9zdGdyZXNxbF90KQphbGxvdyBwb3N0Z3Jlc3FsX3Qg
c2VsZjpmaWZvX2ZpbGUgeyBnZXRhdHRyIHJlYWQgd3JpdGUgaW9jdGwgfTsKYWxsb3cgcG9zdGdy
ZXNxbF90IHNlbGY6dW5peF9zdHJlYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7CmFsbG93
IHBvc3RncmVzcWxfdCBzZWxmOnVuaXhfZGdyYW1fc29ja2V0IGNyZWF0ZV9zb2NrZXRfcGVybXM7
CiMgYWxsb3cgYW55IGRvbWFpbiB0byBjb25uZWN0IHRvIHRoZSBMREFQIHNlcnZlcgpjYW5fdGNw
X2Nvbm5lY3QoZG9tYWluLCBwb3N0Z3Jlc3FsX3QpCgphbGxvdyBwb3N0Z3Jlc3FsX3QgcHJvY190
OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKCiMgQWxsb3cgYWNjZXNzIHRvIHRoZSBwb3N0Z3Jlc3Fs
IGRhdGFiYXNlcwpjcmVhdGVfZGlyX2ZpbGUocG9zdGdyZXNxbF90LCBwb3N0Z3Jlc3FsX2RiX3Qp
CmFsbG93IHBvc3RncmVzcWxfdCB2YXJfbGliX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsKCiMg
cmVhZCBjb25maWcgZmlsZXMKYWxsb3cgcG9zdGdyZXNxbF90IHsgZXRjX3QgZXRjX3J1bnRpbWVf
dCB9OnsgZmlsZSBsbmtfZmlsZSB9IHsgcmVhZCBnZXRhdHRyIH07CnJfZGlyX2ZpbGUocG9zdGdy
ZXNxbF90LCBldGNfcG9zdGdyZXNxbF90KQoKYWxsb3cgcG9zdGdyZXNxbF90IGV0Y190OmRpciBy
d19kaXJfcGVybXM7CmFsbG93IHBvc3RncmVzcWxfdCBldGNfdDpsbmtfZmlsZSBjcmVhdGU7Cgph
bGxvdyBwb3N0Z3Jlc3FsX3QgeyBzeXNjdGxfdCBzeXNjdGxfa2VybmVsX3QgfTpkaXIgc2VhcmNo
OwphbGxvdyBwb3N0Z3Jlc3FsX3Qgc3lzY3RsX2tlcm5lbF90OmZpbGUgcmVhZDsKCmFsbG93IHBv
c3RncmVzcWxfdCBkZXZ0dHlfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsKYWxsb3cgcG9zdGdy
ZXNxbF90IGRldnB0c190OmRpciBzZWFyY2g7CgpjYW5fZXhlYyhwb3N0Z3Jlc3FsX3QsIHsgcG9z
dGdyZXNxbF9leGVjX3QgYmluX3Qgc2Jpbl90IGxzX2V4ZWNfdCBzdV9leGVjX3Qgc2hlbGxfZXhl
Y190IGV0Y190IH0pCmFsbG93IHBvc3RncmVzcWxfdCB7IGJpbl90IHNiaW5fdCB9OmRpciBzZWFy
Y2g7CmFsbG93IHBvc3RncmVzcWxfdCBiaW5fdDpsbmtfZmlsZSByZWFkOwphbGxvdyBwb3N0Z3Jl
c3FsX3QgcG9zdGdyZXNxbF9leGVjX3Q6bG5rX2ZpbGUgcmVhZDsKCmFsbG93IHBvc3RncmVzcWxf
dCBpbml0cmNfdmFyX3J1bl90OmZpbGUgeyByZWFkIHdyaXRlIGxvY2sgfTsKCmFsbG93IHBvc3Rn
cmVzcWxfdCBzZWxmOnNlbSByd19zZW1fcGVybXM7CgphbGxvdyBwb3N0Z3Jlc3FsX3Qgc2VsZjp1
ZHBfc29ja2V0IHJlY3Zmcm9tOwphbGxvdyBkb21haW4gcG9zdGdyZXNxbF90OnVuaXhfc3RyZWFt
X3NvY2tldCBjb25uZWN0dG87CmFsbG93IGRvbWFpbiB2YXJfcnVuX3Bvc3RncmVzcWxfdDpzb2Nr
X2ZpbGUgd3JpdGU7Cg==

--------------Boundary-00=_EXA8ZMBUV3WEL3AFMGDC--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
