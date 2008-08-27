In-Reply-To: <200808271149.38256.paul.moore@hp.com>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu> <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil> <200808271149.38256.paul.moore@hp.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: multipart/alternative; boundary=Apple-Mail-822-1035169481
Message-Id: <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Socket and inode label consistency
Date: Wed, 27 Aug 2008 14:08:57 -0400
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-822-1035169481
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Aug 27, 2008, at 11:49 AM, Paul Moore wrote:

> On Wednesday 27 August 2008 7:57:34 am Stephen Smalley wrote:
>> On Tue, 2008-08-26 at 20:50 -0400, Trent Jaeger wrote:
>>> Hi,
>>>
>>> I see on the Kernel Development To Do list at http://
>>> selinuxproject.org/page/Kernel_Development that the following task
>>> is identified:
>>>
>>> "Full APIs for getting and setting security contexts of sockets and
>>> IPC objects. Ensure that socket context is kept consistent on
>>> socket inode and sock structures when changed."
>>>
>>> We are being bitten by this now, so I am wondering if anyone is
>>> working on it or wishes to discuss how to proceed.  We would be
>>> interested in addressing this issue.
>>
>> I don't know of anyone working on it, but we are interested in it.
>
> It is something that has been on my todo list for some time but it is
> stuck with such a low priority that I haven't been able to make any
> progress on it.  If you've got time to work on it, I would be very
> happy :)
>
>> As I recall, you can get and set the socket inode label via fgetxattr
>> and fsetxattr but the struct sock label isn't accessible from
>> userspace (except via getpeercon, and then only for the peer).  I
>> think you'd need to add a .setxattr method to the socket_file_ops and
>> have them call into the LSM interface to update the sock information
>> (as well as continuing to update the socket inode info).
>
> There would also need to be some work done to ensure that all the
> outbound labeled networking stuff is updated when the socket's  
> label is
> changed via the xattr operations.  Right now there is no way (at least
> not that I know of) to change the label of an existing socket so we
> don't have to worry about that problem.
>
> I also wonder about changing the label of a socket while it is
> connected, probably not a big issue for dgram sockets but I think it
> could get pretty strange for stream sockets.

Hi,

What we want is to create a socket within the context of a multilevel  
secure process.  For example, if the process has an MLS range of s0- 
s1, we may want an s0 or s1 socket.

Thus, in theory, we should be able to avoid dealing with context  
changes on connected sockets and such.  Once the socket goes into any  
use, it cannot be relabeled.

I am not sure that setxattr will work as this is an inode operation,  
and I do not see a reference from an inode to an associated socket.

Originally, I was thinking of setsockopt, but I agree that it would  
be nice to deal with it via the file interface, like fsetfilecon.

Thoughts?

Regards,
Trent.
----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176




--Apple-Mail-822-1035169481
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><html>On Aug 27, 2008, at 11:49 AM, Paul Moore wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Wednesday 27 August 2008 7:57:34 am Stephen =
Smalley wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">On Tue, =
2008-08-26 at 20:50 -0400, Trent Jaeger wrote:</div> <blockquote =
type=3D"cite"><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Hi,</div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I see on the =
Kernel Development To Do list at http://</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">selinuxproject.org/page/Kernel_Development that the following =
task</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">is identified:</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">"Full =
APIs for getting and setting security contexts of sockets and</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">IPC objects. Ensure that socket context is kept =
consistent on</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">socket inode and sock structures =
when changed."</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">We are being bitten by this now, so I am wondering =
if anyone is</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">working on it or wishes to =
discuss how to proceed.<span class=3D"Apple-converted-space">=A0 =
</span>We would be</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">interested in addressing =
this issue.</div> </blockquote><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I don't know of anyone working =
on it, but we are interested in it.</div> </blockquote><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">It is =
something that has been on my todo list for some time but it is<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">stuck =
with such a low priority that I haven't been able to make any<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">progress =
on it.<span class=3D"Apple-converted-space">=A0 </span>If you've got =
time to work on it, I would be very<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">happy =
:)</div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; min-height: 14px; "><br></div> <blockquote =
type=3D"cite"><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">As I recall, you can get and set =
the socket inode label via fgetxattr</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">and fsetxattr =
but the struct sock label isn't accessible from</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">userspace (except via getpeercon, and then only for =
the peer).<span class=3D"Apple-converted-space">=A0 </span>I</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">think you'd need to add a .setxattr method to the =
socket_file_ops and</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">have them call into the LSM =
interface to update the sock information</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">(as well =
as continuing to update the socket inode info).</div> </blockquote><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">There =
would also need to be some work done to ensure that all the<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">outbound =
labeled networking stuff is updated when the socket's label is<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">changed =
via the xattr operations.<span class=3D"Apple-converted-space">=A0 =
</span>Right now there is no way (at least<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">not that =
I know of) to change the label of an existing socket so we<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">don't =
have to worry about that problem.</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I also wonder about changing the =
label of a socket while it is<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">connected, probably not a big issue for dgram sockets but I think =
it<span class=3D"Apple-converted-space">=A0</span></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">could get pretty strange for stream =
sockets.</div></blockquote><br></div><div>Hi,</div><div><br></div><div>Wha=
t we want is to create a socket within the context of a multilevel =
secure process. =A0For example, if the process has an MLS range of =
s0-s1, we may want an s0 or s1 socket. =A0</div><div><br></div><div>Thus, =
in theory, we should be able to avoid dealing with context changes on =
connected sockets and such. =A0Once the socket goes into any use, it =
cannot be relabeled.</div><div><br></div><div>I am not sure that =
setxattr will work as this is an inode operation, and I do not see a =
reference from an inode to an associated socket. =
=A0</div><div><br></div><div>Originally, I was thinking of setsockopt, =
but I agree that it would be nice to deal with it via the file =
interface, like =
fsetfilecon.</div><div><br></div><div>Thoughts?</div><div><br></div><div> =
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; =
"><div>Regards,</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Trent.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">----------------------------------------------</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Trent Jaeger, Associate Professor</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Pennsylvania State University, CSE Dept</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">346A IST Bldg, University Park, PA 16802</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Email: <a =
href=3D"mailto:tjaeger@cse.psu.edu">tjaeger@cse.psu.edu</a></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Ph: (814) 865-1042, Fax: (814) 865-3176</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><br class=3D"khtml-block-placeholder"></div><br =
class=3D"Apple-interchange-newline"></span> </div><br></body></html>=

--Apple-Mail-822-1035169481--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
