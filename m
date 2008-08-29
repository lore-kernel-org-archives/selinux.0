In-Reply-To: <1220011999.5708.268.camel@moss-spartans.epoch.ncsc.mil>
References: <1D98C7BF-3D76-4A9C-B43C-31BE0C57227B@cse.psu.edu> <1219838254.5708.4.camel@moss-spartans.epoch.ncsc.mil> <200808271149.38256.paul.moore@hp.com> <E0F1193F-FE77-4B1D-87BA-3289AD37C385@cse.psu.edu> <1219861005.5708.137.camel@moss-spartans.epoch.ncsc.mil> <48B5B3DF.4080404@schaufler-ca.com> <4A385C00-E89F-43D3-8ACA-E7B27AC97B5E@cse.psu.edu> <48B5DADF.9060005@schaufler-ca.com> <1219925583.5708.149.camel@moss-spartans.epoch.ncsc.mil> <495E0F32-F676-4FC7-8931-6A67FAFB47DC@cse.psu.edu> <48B77988.9080504@schaufler-ca.com> <1220011999.5708.268.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: multipart/alternative; boundary=Apple-Mail-855--941603759
Message-Id: <D02668AD-6FF9-4C1F-AD21-0140B43394A6@cse.psu.edu>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
From: Trent Jaeger <tjaeger@cse.psu.edu>
Subject: Re: Socket and inode label consistency
Date: Fri, 29 Aug 2008 13:34:08 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-855--941603759
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Aug 29, 2008, at 8:13 AM, Stephen Smalley wrote:

>
> On Thu, 2008-08-28 at 21:22 -0700, Casey Schaufler wrote:
>> Trent Jaeger wrote:
>>> ...
>>>>
>>>> However it sounded like you could just use setsockcreatecon(3) to
>>>> achieve your goal, which would be cleaner than relabeling an  
>>>> existing
>>>> socket.
>>>
>>> Yes, that works for what we are doing now.  I'd be curious if  
>>> someone
>>> has a need beyond setting a label on creation.
>>>
>>
>> Sure, any service that wants to serve clients with a variety of  
>> labels.
>> The X server is an obvious candidate. A multi-label message bus.  
>> Label
>> aware sendmail. xinetd. Name services (the YP/NIS of the day).  
>> Anywhere
>> you want the label of the response to depend on the label of the  
>> request.
>> Yes, we're talking about Trusted Applications here, and specially  
>> coded
>> ones at that. Sometimes that's the best way.
>
> The application doesn't have to relabel the socket to achieve that  
> - we
> handle that when we compute the label for the new connection socket
> based in part on the label of the connecting request.

Yes, we prototyped this for xinetd (see SecureComm 2006 paper), and  
did not relabel the socket, but used the label of SA for the request.

Regards,
Trent.
----------------------------------------------
Trent Jaeger, Associate Professor
Pennsylvania State University, CSE Dept
346A IST Bldg, University Park, PA 16802
Email: tjaeger@cse.psu.edu
Ph: (814) 865-1042, Fax: (814) 865-3176




--Apple-Mail-855--941603759
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><html>On Aug 29, 2008, at 8:13 AM, Stephen Smalley =
wrote:</html><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Thu, 2008-08-28 at 21:22 -0700, Casey Schaufler =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Trent Jaeger =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">...</div> =
<blockquote type=3D"cite"><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">However it sounded like you =
could just use setsockcreatecon(3) to</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">achieve =
your goal, which would be cleaner than relabeling an existing</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">socket.</div> </blockquote><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Yes, that =
works for what we are doing now.<span class=3D"Apple-converted-space">=A0 =
</span>I'd be curious if someone<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">has a =
need beyond setting a label on creation.</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div> </blockquote><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Sure, any =
service that wants to serve clients with a variety of labels.</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">The X server is an obvious candidate. A multi-label =
message bus. Label</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">aware sendmail. xinetd. =
Name services (the YP/NIS of the day). Anywhere</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">you want the label of the response to depend on the =
label of the request.</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">Yes, we're talking about =
Trusted Applications here, and specially coded</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">ones at that. Sometimes that's the best way.</div> =
</blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">The application doesn't have to relabel the socket =
to achieve that - we</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">handle that when we compute =
the label for the new connection socket</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">based in =
part on the label of the connecting =
request.</div></blockquote><br></div><div>Yes, we prototyped this for =
xinetd (see SecureComm 2006 paper), and did not relabel the socket, but =
used the label of SA for the request.</div><div><br></div><div> <span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
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

--Apple-Mail-855--941603759--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
