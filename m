In-Reply-To: <200808271434.04677.paul.moore@hp.com>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu> <1219860339.2910.22.camel@localhost.localdomain> <5680A933-013B-413E-8012-BD843F8C22BE@cse.psu.edu> <200808271434.04677.paul.moore@hp.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: multipart/alternative; boundary=Apple-Mail-828-1042747232
Message-Id: <7B571F97-678E-4BCF-8E30-E1F0F08F86FB@cse.psu.edu>
Cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Socket and inode label consistency
Date: Wed, 27 Aug 2008 16:15:15 -0400
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-828-1042747232
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Aug 27, 2008, at 2:34 PM, Paul Moore wrote:

> On Wednesday 27 August 2008 2:20:48 pm Trent Jaeger wrote:
>> On Aug 27, 2008, at 2:05 PM, Eric Paris wrote:
>>>> Hi,
>>>>
>>>>
>>>> What we want is to create a socket within the context of a
>>>> multilevel secure process.  For example, if the process has an MLS
>>>> range of s0-s1, we may want an s0 or s1 socket.
>>>>
>>>>
>>>> Thus, in theory, we should be able to avoid dealing with context
>>>> changes on connected sockets and such.  Once the socket goes into
>>>> any use, it cannot be relabeled.
>>>>
>>>>
>>>> I am not sure that setxattr will work as this is an inode
>>>> operation, and I do not see a reference from an inode to an
>>>> associated socket.
>>>>
>>>>
>>>> Originally, I was thinking of setsockopt, but I agree that it
>>>> would be
>>>> nice to deal with it via the file interface, like fsetfilecon.
>>>
>>> /proc/self/attr/sockcreate and I know I wrote some libselinux stuff
>>> around it too....
>>
>> OK.  We'll take a look.
>
> Yeah, as others have said setsockcreatecon() is your friend here.  If
> you need a working example there is a test utility included in the
> audit-test project on sourceforge[1] which uses setsockcreatecon() to
> create some strangely labeled sockets.  If you download the audit-test
> sources the tool can be found in utils/network-server; it isn't the
> prettiest piece of code but it works ;)
>
> If you have any questions or problems don't hesitate to ask.
>
> [1] http://sourceforge.net/projects/audit-test
>

That is great.  Thanks.

Regards,
Trent.
----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176




--Apple-Mail-828-1042747232
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><html>On Aug 27, 2008, at 2:34 PM, Paul Moore wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Wednesday 27 August 2008 2:20:48 pm Trent Jaeger =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">On Aug 27, =
2008, at 2:05 PM, Eric Paris wrote:</div> <blockquote =
type=3D"cite"><blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Hi,</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">What we want =
is to create a socket within the context of a</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">multilevel secure process.<span =
class=3D"Apple-converted-space">=A0 </span>For example, if the process =
has an MLS</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">range of s0-s1, we may want an =
s0 or s1 socket.</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Thus, in =
theory, we should be able to avoid dealing with context</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">changes on connected sockets and such.<span =
class=3D"Apple-converted-space">=A0 </span>Once the socket goes =
into</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">any use, it cannot be =
relabeled.</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I am not =
sure that setxattr will work as this is an inode</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">operation, and I do not see a reference from an =
inode to an</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">associated socket.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Originally, I =
was thinking of setsockopt, but I agree that it</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">would be</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">nice to deal =
with it via the file interface, like fsetfilecon.</div> =
</blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">/proc/self/attr/sockcreate and I know I wrote some =
libselinux stuff</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">around it too....</div> =
</blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">OK.<span class=3D"Apple-converted-space">=A0 =
</span>We'll take a look.</div> </blockquote><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Yeah, as =
others have said setsockcreatecon() is your friend here.<span =
class=3D"Apple-converted-space">=A0 </span>If<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">you need =
a working example there is a test utility included in the<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">audit-test project on sourceforge[1] which uses setsockcreatecon() =
to<span class=3D"Apple-converted-space">=A0</span></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">create some strangely labeled sockets.<span =
class=3D"Apple-converted-space">=A0 </span>If you download the =
audit-test<span class=3D"Apple-converted-space">=A0</span></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">sources the tool can be found in =
utils/network-server; it isn't the<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">prettiest piece of code but it works ;)</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">If you have =
any questions or problems don't hesitate to ask.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">[1] <a =
href=3D"http://sourceforge.net/projects/audit-test">http://sourceforge.net=
/projects/audit-test</a></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div></blockquote><br></div><div>That is great. =
=A0Thanks.</div><div><br></div><div> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
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

--Apple-Mail-828-1042747232--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
