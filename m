Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1OG1QnE023573
	for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 11:01:26 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1OG2kFV000098
	for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 16:02:46 GMT
Received: by nz-out-0506.google.com with SMTP id z3so715559nzf
        for <selinux@tycho.nsa.gov>; Sat, 24 Feb 2007 08:02:45 -0800 (PST)
Message-ID: <e739902b0702240802p709ced8ao2c39bb6cfe105b3b@mail.gmail.com>
Date: Sat, 24 Feb 2007 08:02:44 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Is the usercanread attribute still needed?
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1172248387.15371.66.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_69866_3257252.1172332964892"
References: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
	 <1172004294.20576.236.camel@sgc.columbia.tresys.com>
	 <e739902b0702201944t104d6915raff5949c8e579885@mail.gmail.com>
	 <e739902b0702201951p813ad71vefb0dd0069448a07@mail.gmail.com>
	 <1172248387.15371.66.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_69866_3257252.1172332964892
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Chris,

I thought I did forward the patch, but it looks like the foward
stripped the patch :(
Here is the patch again.

Thanks!

- Ryan



On 2/23/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > On 2/20/07, Ryan Bradetich <rbradetich@gmail.com> wrote:
> > > Hello Chris,
> > >
> > > Thanks much for your reply!
> > > I have attached an updated patch that leaves the attribute definition
> > > in the files.te file.
> > >
> > > Just out of curiosity, what is the policy for obsoleting these attributes?
> > > At next policy file rev?
>
> It has to stay around for "a reasonable transition time".  Since this is
> a fairly widely used interface, it'll probably have to stay for a few
> releases.
>
> Please resend the patch to the list.
>
> > > On 2/20/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > > > Since modules are statically compiled, we can't completely remove the
> > > > attribute yet, otherwise it might cause some policies to fail to link if
> > > > it is still required.  However, the typeattribute could be removed from
> > > > files_config_file().
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

------=_Part_69866_3257252.1172332964892
Content-Type: text/x-patch; name=files2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyk8qjxl
Content-Disposition: attachment; filename="files2.patch"

SW5kZXg6IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy5pZgo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwb2xp
Y3kvbW9kdWxlcy9rZXJuZWwvZmlsZXMuaWYJKHJldmlzaW9uIDIxODIpCisrKyBwb2xpY3kvbW9k
dWxlcy9rZXJuZWwvZmlsZXMuaWYJKHdvcmtpbmcgY29weSkKQEAgLTExMCwxNCArMTEwLDcgQEAK
ICMjIDwvcGFyYW0+CiAjCiBpbnRlcmZhY2UoYGZpbGVzX2NvbmZpZ19maWxlJyxgCi0JZ2VuX3Jl
cXVpcmUoYAotCQlhdHRyaWJ1dGUgdXNlcmNhbnJlYWQ7Ci0JJykKLQogCWZpbGVzX3R5cGUoJDEp
Ci0KLQkjIHRoaXMgaXMgYSBoYWNrIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4KLQl0eXBlYXR0cmli
dXRlICQxIHVzZXJjYW5yZWFkOwogJykKIAogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpJbmRleDogcG9saWN5L21vZHVsZXMva2VybmVsL2ZpbGVzLnRlCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy50ZQkocmV2aXNpb24gMjE4MikKKysr
IHBvbGljeS9tb2R1bGVzL2tlcm5lbC9maWxlcy50ZQkod29ya2luZyBjb3B5KQpAQCAtMzAsNyAr
MzAsOSBAQAogYXR0cmlidXRlIHRtcGZpbGU7CiBhdHRyaWJ1dGUgdG1wZnNmaWxlOwogCi0jIHRo
aXMgaXMgYSBoYWNrIGFuZCBzaG91bGQgYmUgY2hhbmdlZAorIyB0aGlzIGF0dHJpYnV0ZSBpcyBu
b3QgY3VycmVudGx5IHVzZWQgYW5kIHNob3VsZCBiZSByZW1vdmVkIGluIHRoZSBmdXR1cmUuCisj
IHVuZm9ydGVuYXRlbHksIHRoaXMgYXR0cmlidXRlIGNhbiBub2IgYmUgcmVtb3ZlZCB5ZXQgYmVj
YXVzZSBpdCBtYXkgZmFpbAorIyBzb21lIHBvbGljaWVzIHRvIGZhaWwgdG8gbGluayBpZiBpdCBp
cyBzdGlsbCByZXF1aXJlZC4KIGF0dHJpYnV0ZSB1c2VyY2FucmVhZDsKIAogIwo=
------=_Part_69866_3257252.1172332964892--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
