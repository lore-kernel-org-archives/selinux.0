Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JF9Gdq017220
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 11:09:16 -0400
Received: from el-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2JF9EYY011650
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 15:09:14 GMT
Received: by el-out-1112.google.com with SMTP id v27so331494ele.17
        for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 08:09:11 -0700 (PDT)
Message-ID: <8b4cbe570803190802k4a597140p41a042dae85b0bcb@mail.gmail.com>
Date: Wed, 19 Mar 2008 11:02:31 -0400
From: "B Topscher" <bryan@jennandbryan.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: unix_domain_sockets in mls
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1205937798.6466.223.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3313_20644437.1205938951841"
References: <8b4cbe570803190704u56b1181ta9502561324dd7f4@mail.gmail.com>
	 <1205937798.6466.223.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3313_20644437.1205938951841
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Will I be allowed to use setsockcreatecon() on my
system_u:levmA_r:levmA_t:s4-s4:c1,c100
process to set the connection to s4:c1 prior to connecting to the server
from the client?  This would be the ideal way for me to do it given the
information available.

Ideally we want the connection to be made at s4:c1 level because it is the
common mls level.   If there is another way to do it let me know.

Thank you
Bryan

On 3/19/08, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>
> On Wed, 2008-03-19 at 10:04 -0400, B Topscher wrote:
> > FWD from a coworker:
> >
> >
> > I'm a policy newbie, writing a custom module to allow streaming data
> > through unix domain sockets on an mls system.
> >
> >
> >
> > My problem is that, no matter what I do, I can't seem to transition
> > either the type or the level of the unix_stream_socket.
>
>
> Transitions would apply to the socket file, not to the socket itself.
> They are two distinct objects with distinct labels - the file is merely
> a way of referencing the Unix/local socket, much as a port is merely a
> way of referencing a TCP socket.
>
> Sockets always inherit the context of their creator unless the task used
> the setsockcreatecon() interface of libselinux.  Except for new
> connection sockets, which have a mixed model - they inherit the type
> from the server but the MLS level from the client in order to reflect
> back the client's level for level preservation.
>
>
> > My three processes have the following contexts:
> >
> > system_u:servA_r:servA_t:s4:c1
> >
> > system_u:levmA_r:levmA_t:s4-s4:c1,c100
> >
> > system_u:FCM_r:FCM_t:s4:c100
> >
> >
> >
> > Ideally, servA should be able to talk to levmA on a unix_stream_socket
> > at running at s4:c1, levmA should be able to read from s4:c1 and
> > writeinrange (via a custom mls attribute and a modification of the
> > mlsconstraints) to s4:c100. Another perfectly acceptable solution
> > would be to set the levmA unix_stream_socket to levmA's clearance
> > level (s4:c1,c100). What's important here is that I do not want to
> > allow the servA_t context to "write-down".  That should be reserved
> > only to the levm process.
> >
> >
> >
> > What I'm seeing is that, regardless of the permissions on the
> > sock_file, when levmA connects to the servA unix_stream_socket, the
> > target context takes the servA_t type, but keeps the mls level of the
> > levmA process. The AVC message is as follows:
> >
> > type=AVC msg=audit(1205874819.221:1476): avc:  denied  { write } for
> > pid=3303 comm="ServA" name="[59950]" dev=sockfs ino=59950
> > scontext=system_u:servA_r:servA_t:s4:c1
> > tcontext=system_u:servA_r:servA_t:s4-s4:c1,c100
> > tclass=unix_stream_socket
>
>
> This isn't related to the socket file.  What appears to be happening
> here is that the server accepted a connection from the client, and the
> new connection socket was labeled with the type of the server and the
> level of the client, which is correct.  Then when the server tries to
> write on that connection, it gets denied due to the mismatch in MLS
> ranges - the server is only running at s4:c1 while the client is ranged.
>
> Transitions aren't going to help with this issue.
>
>
> >
> >         Was caused by:
> >
> >                 Constraint violation.
> >
> >                 Check policy/constraints.
> >
> >                 Typically, you just need to add a type attribute to
> > the domain to satisfy the constraint.
> >
> >
> >
> > It's failing because that ranged tcontext s4-s4:c1,c100 makes it a
> > "write-down" operation (s4:c1 to s4). I have found nothing that can
> > actually affect the context of the target unix_stream_socket. What am
> > I missing?
> >
> >
> >
> > Here are some of the relevant snippets of the policy:
> >
> >
> >
> > #from the .te file.
> >
> > levm_bidir(high, levmA, h2l, s4, c1, servA, s4, c100, FCM)
> >
> >
> > levm_bidir(high, levmA, h2l, s4, c100, FCM, s4, c1, servA)
> >
> >
> >
> > #from the .if file. Lots of superfluous transition statements to see
> > if anything can affect the unix_stream_socket
> >
> >     allow $2_t self:unix_stream_socket { create_stream_socket_perms
> > connectto };
> >
> >     allow $2_t $9_t:unix_stream_socket { create_stream_socket_perms
> > connectto };
> >
> >     allow $9_t self:unix_stream_socket { create_stream_socket_perms
> > connectto };
> >
> >     filetrans_add_pattern($2_t, $9_dir_t, $9_t, file)
> >
> >     filetrans_add_pattern($2_t, $9_dir_t, $9_t, sock_file)
> >
> >     filetrans_add_pattern($2_t, $9_t, $2_t, unix_stream_socket)
> >
> >     filetrans_add_pattern($2_t, $9_dir_t, $2_t, unix_stream_socket)
> >
> >     range_transition $2_t $9_dir_t:file $7:$8;
> >
> >     range_transition $2_t $9_dir_t:sock_file $7:$8;
> >
> >     range_transition $2_t $9_t:unix_stream_socket $7:8;
> >
> >     range_transition $2_t $2_t:unix_stream_socket $7:8;
> >
> >     range_transition $9_t $9_t:unix_stream_socket $7:8;
> >
> >
> >
> > Best regards,
> >
> >
> >
> > Tim
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_3313_20644437.1205938951841
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Will I be allowed to use setsockcreatecon() on my <span class="q">system_u:levmA_r:levmA_t:s4-s4:c1,c100 process to set the connection to </span><span class="q">s4:c1 prior to connecting to the server from the client?&nbsp; This would be the ideal way for me to do it given the information available. <br>
<br>Ideally we want the connection to be made at s4:c1 level because it is the common mls level.&nbsp;&nbsp; If there is another way to do it let me know.<br><br>Thank you<br>Bryan<br></span><br><div><span class="gmail_quote">On 3/19/08, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">sds@tycho.nsa.gov</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br> On Wed, 2008-03-19 at 10:04 -0400, B Topscher wrote:<br> &gt; FWD from a coworker:<br> &gt;<br> &gt;<br> &gt; I&#39;m a policy newbie, writing a custom module to allow streaming data<br> &gt; through unix domain sockets on an mls system.<br>

 &gt;<br> &gt;<br> &gt;<br> &gt; My problem is that, no matter what I do, I can&#39;t seem to transition<br> &gt; either the type or the level of the unix_stream_socket.<br> <br> <br>Transitions would apply to the socket file, not to the socket itself.<br>

 They are two distinct objects with distinct labels - the file is merely<br> a way of referencing the Unix/local socket, much as a port is merely a<br> way of referencing a TCP socket.<br> <br> Sockets always inherit the context of their creator unless the task used<br>

 the setsockcreatecon() interface of libselinux.&nbsp;&nbsp;Except for new<br> connection sockets, which have a mixed model - they inherit the type<br> from the server but the MLS level from the client in order to reflect<br> back the client&#39;s level for level preservation.<br>

 <br><br> &gt; My three processes have the following contexts:<br> &gt;<br> &gt; system_u:servA_r:servA_t:s4:c1<br> &gt;<br> &gt; system_u:levmA_r:levmA_t:s4-s4:c1,c100<br> &gt;<br> &gt; system_u:FCM_r:FCM_t:s4:c100<br> &gt;<br>

 &gt;<br> &gt;<br> &gt; Ideally, servA should be able to talk to levmA on a unix_stream_socket<br> &gt; at running at s4:c1, levmA should be able to read from s4:c1 and<br> &gt; writeinrange (via a custom mls attribute and a modification of the<br>

 &gt; mlsconstraints) to s4:c100. Another perfectly acceptable solution<br> &gt; would be to set the levmA unix_stream_socket to levmA&#39;s clearance<br> &gt; level (s4:c1,c100). What&#39;s important here is that I do not want to<br>

 &gt; allow the servA_t context to &quot;write-down&quot;.&nbsp;&nbsp;That should be reserved<br> &gt; only to the levm process.<br> &gt;<br> &gt;<br> &gt;<br> &gt; What I&#39;m seeing is that, regardless of the permissions on the<br>

 &gt; sock_file, when levmA connects to the servA unix_stream_socket, the<br> &gt; target context takes the servA_t type, but keeps the mls level of the<br> &gt; levmA process. The AVC message is as follows:<br> &gt;<br>
 &gt; type=AVC msg=audit(1205874819.221:1476): avc:&nbsp;&nbsp;denied&nbsp;&nbsp;{ write } for<br>
 &gt; pid=3303 comm=&quot;ServA&quot; name=&quot;[59950]&quot; dev=sockfs ino=59950<br> &gt; scontext=system_u:servA_r:servA_t:s4:c1<br> &gt; tcontext=system_u:servA_r:servA_t:s4-s4:c1,c100<br> &gt; tclass=unix_stream_socket<br>

 <br> <br>This isn&#39;t related to the socket file.&nbsp;&nbsp;What appears to be happening<br> here is that the server accepted a connection from the client, and the<br> new connection socket was labeled with the type of the server and the<br>

 level of the client, which is correct.&nbsp;&nbsp;Then when the server tries to<br> write on that connection, it gets denied due to the mismatch in MLS<br> ranges - the server is only running at s4:c1 while the client is ranged.<br>

 <br> Transitions aren&#39;t going to help with this issue.<br> <br><br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Was caused by:<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Constraint violation.<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Check policy/constraints.<br>

 &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Typically, you just need to add a type attribute to<br> &gt; the domain to satisfy the constraint.<br> &gt;<br> &gt;<br> &gt;<br> &gt; It&#39;s failing because that ranged tcontext s4-s4:c1,c100 makes it a<br>

 &gt; &quot;write-down&quot; operation (s4:c1 to s4). I have found nothing that can<br> &gt; actually affect the context of the target unix_stream_socket. What am<br> &gt; I missing?<br> &gt;<br> &gt;<br> &gt;<br> &gt; Here are some of the relevant snippets of the policy:<br>

 &gt;<br> &gt;<br> &gt;<br> &gt; #from the .te file.<br> &gt;<br> &gt; levm_bidir(high, levmA, h2l, s4, c1, servA, s4, c100, FCM)<br> &gt;<br> &gt;<br> &gt; levm_bidir(high, levmA, h2l, s4, c100, FCM, s4, c1, servA)<br> &gt;<br>

 &gt;<br> &gt;<br> &gt; #from the .if file. Lots of superfluous transition statements to see<br> &gt; if anything can affect the unix_stream_socket<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; allow $2_t self:unix_stream_socket { create_stream_socket_perms<br>

 &gt; connectto };<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; allow $2_t $9_t:unix_stream_socket { create_stream_socket_perms<br> &gt; connectto };<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; allow $9_t self:unix_stream_socket { create_stream_socket_perms<br> &gt; connectto };<br>

 &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $9_t, file)<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $9_t, sock_file)<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_t, $2_t, unix_stream_socket)<br>

 &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $2_t, unix_stream_socket)<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; range_transition $2_t $9_dir_t:file $7:$8;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; range_transition $2_t $9_dir_t:sock_file $7:$8;<br>

 &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; range_transition $2_t $9_t:unix_stream_socket $7:8;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; range_transition $2_t $2_t:unix_stream_socket $7:8;<br> &gt;<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp; range_transition $9_t $9_t:unix_stream_socket $7:8;<br>

 &gt;<br> &gt;<br> &gt;<br> &gt; Best regards,<br> &gt;<br> &gt;<br> &gt;<br> &gt; Tim<br> <br>--<br> Stephen Smalley<br> National Security Agency<br> <br> </blockquote></div><br>

------=_Part_3313_20644437.1205938951841--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
