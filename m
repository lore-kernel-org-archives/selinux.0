Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JE4TwA009054
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 10:04:29 -0400
Received: from wr-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2JE4MYY004852
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 14:04:22 GMT
Received: by wr-out-0506.google.com with SMTP id c30so391824wra.21
        for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 07:04:17 -0700 (PDT)
Message-ID: <8b4cbe570803190704u56b1181ta9502561324dd7f4@mail.gmail.com>
Date: Wed, 19 Mar 2008 10:04:10 -0400
From: "B Topscher" <bryan@jennandbryan.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: unix_domain_sockets in mls
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3024_26320051.1205935455928"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3024_26320051.1205935455928
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

FWD from a coworker:


I'm a policy newbie, writing a custom module to allow streaming data through
unix domain sockets on an mls system.



My problem is that, no matter what I do, I can't seem to transition either
the type or the level of the unix_stream_socket.

My three processes have the following contexts:

system_u:servA_r:servA_t:s4:c1

system_u:levmA_r:levmA_t:s4-s4:c1,c100

system_u:FCM_r:FCM_t:s4:c100



Ideally, servA should be able to talk to levmA on a unix_stream_socket at
running at s4:c1, levmA should be able to read from s4:c1 and writeinrange
(via a custom mls attribute and a modification of the mlsconstraints) to
s4:c100. Another perfectly acceptable solution would be to set the levmA
unix_stream_socket to levmA's clearance level (s4:c1,c100). What's important
here is that I do not want to allow the servA_t context to "write-down".
That should be reserved only to the levm process.



What I'm seeing is that, regardless of the permissions on the sock_file,
when levmA connects to the servA unix_stream_socket, the target context
takes the servA_t type, but keeps the mls level of the levmA process. The
AVC message is as follows:

type=AVC msg=audit(1205874819.221:1476): avc:  denied  { write } for
pid=3303 comm="ServA" name="[59950]" dev=sockfs ino=59950
scontext=system_u:servA_r:servA_t:s4:c1
tcontext=system_u:servA_r:servA_t:s4-s4:c1,c100 tclass=unix_stream_socket

        Was caused by:

                Constraint violation.

                Check policy/constraints.

                Typically, you just need to add a type attribute to the
domain to satisfy the constraint.



It's failing because that ranged tcontext s4-s4:c1,c100 makes it a
"write-down" operation (s4:c1 to s4). I have found nothing that can actually
affect the context of the target unix_stream_socket. What am I missing?



Here are some of the relevant snippets of the policy:



#from the .te file.

levm_bidir(high, levmA, h2l, s4, c1, servA, s4, c100, FCM)


levm_bidir(high, levmA, h2l, s4, c100, FCM, s4, c1, servA)



#from the .if file. Lots of superfluous transition statements to see if
anything can affect the unix_stream_socket

    allow $2_t self:unix_stream_socket { create_stream_socket_perms
connectto };

    allow $2_t $9_t:unix_stream_socket { create_stream_socket_perms
connectto };

    allow $9_t self:unix_stream_socket { create_stream_socket_perms
connectto };

    filetrans_add_pattern($2_t, $9_dir_t, $9_t, file)

    filetrans_add_pattern($2_t, $9_dir_t, $9_t, sock_file)

    filetrans_add_pattern($2_t, $9_t, $2_t, unix_stream_socket)

    filetrans_add_pattern($2_t, $9_dir_t, $2_t, unix_stream_socket)

    range_transition $2_t $9_dir_t:file $7:$8;

    range_transition $2_t $9_dir_t:sock_file $7:$8;

    range_transition $2_t $9_t:unix_stream_socket $7:8;

    range_transition $2_t $2_t:unix_stream_socket $7:8;

    range_transition $9_t $9_t:unix_stream_socket $7:8;



Best regards,



Tim

------=_Part_3024_26320051.1205935455928
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

FWD from a coworker:<br><br><br><font size="2">I'm a policy newbie, writing a custom module to allow streaming data through unix domain sockets on an mls system.</font><br>
<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">My problem is that, no matter what I do, I can't seem to transition either the type or the level of the unix_stream_socket.</font><br>
<br>
<font size="2">My three processes have the following contexts:</font><br>
<br>
<font size="2">system_u:servA_r:servA_t:s4:c1</font><br>
<br>
<font size="2">system_u:levmA_r:levmA_t:s4-s4:c1,c100</font><br>
<br>
<font size="2">system_u:FCM_r:FCM_t:s4:c100</font><br>
<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">Ideally, servA should be able to talk to levmA on a unix_stream_socket at running at s4:c1, levmA should be able to read from s4:c1 and writeinrange (via a custom mls attribute and a modification of the mlsconstraints) to s4:c100. Another perfectly acceptable solution would be to set the levmA unix_stream_socket to levmA's clearance level (s4:c1,c100). What's important here is that I do not want to allow the servA_t context to "write-down".&nbsp; That should be reserved only to the levm process.</font><br>

<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">What I'm seeing is that, regardless of the permissions on the sock_file, when levmA connects to the servA unix_stream_socket, the target context takes the servA_t type, but keeps the mls level of the levmA process. The AVC message is as follows:</font><br>

<br>
<font size="2">type=AVC msg=audit(1205874819.221:1476): avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=3303 comm=&quot;ServA&quot; name=&quot;[59950]&quot; dev=sockfs ino=59950 scontext=system_u:servA_r:servA_t:s4:c1 tcontext=system_u:servA_r:servA_t:s4-s4:c1,c100 tclass=unix_stream_socket</font><br>

<br>
<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Was caused by:</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Constraint violation.</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Check policy/constraints.</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Typically, you just need to add a type attribute to the domain to satisfy the constraint.</font><br>
<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">It's failing because that ranged tcontext s4-s4:c1,c100 makes it a "write-down" operation (s4:c1 to s4). I have found nothing that can actually affect the context of the target unix_stream_socket. What am I missing?</font><br>

<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">Here are some of the relevant snippets of the policy:</font><br>
<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">#from the .te file.&nbsp; </font><br>
<br>
<font size="2">levm_bidir(high, levmA, h2l, s4, c1, servA, s4, c100, FCM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><br>
<br>
<font size="2">levm_bidir(high, levmA, h2l, s4, c100, FCM, s4, c1, servA)</font><br>
<br>
<font size="2">&nbsp;</font><br>
<br>
<font size="2">#from the .if file. Lots of superfluous transition statements to see if anything can affect the unix_stream_socket</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; allow $2_t self:unix_stream_socket { create_stream_socket_perms connectto }; </font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; allow $2_t $9_t:unix_stream_socket { create_stream_socket_perms connectto };&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; allow $9_t self:unix_stream_socket { create_stream_socket_perms connectto }; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $9_t, file)</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $9_t, sock_file)</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_t, $2_t, unix_stream_socket)</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; filetrans_add_pattern($2_t, $9_dir_t, $2_t, unix_stream_socket)</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; range_transition $2_t $9_dir_t:file $7:$8;</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; range_transition $2_t $9_dir_t:sock_file $7:$8;</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; range_transition $2_t $9_t:unix_stream_socket $7:8;</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; range_transition $2_t $2_t:unix_stream_socket $7:8;</font><br>
<br>
<font size="2">&nbsp;&nbsp;&nbsp; range_transition $9_t $9_t:unix_stream_socket $7:8;</font><br>
<br>
<font size="2"><font color="#000000">&nbsp;</font></font><br>
<br>
<font size="2"><font color="#000000">Best regards,</font></font><br>
<br>
<font size="2"><font color="#000080">&nbsp;</font></font><br>
<br>
<font size="2"><font color="#000080">Tim</font></font>
<br>

------=_Part_3024_26320051.1205935455928--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
