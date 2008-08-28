Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7SKXMpb007604
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 16:33:22 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7SKXMxJ010925
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 20:33:22 GMT
Received: by rv-out-0708.google.com with SMTP id f25so566609rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 13:33:21 -0700 (PDT)
Message-ID: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
Date: Thu, 28 Aug 2008 16:33:21 -0400
From: Hong <kindloaf@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: About Domain Transition
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8224_26923091.1219955601291"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_8224_26923091.1219955601291
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Suppose a process is in domain "CurrDom".  Now the process invokes a program
with type "Type".
Following is my understanding of whether the execution can succeed, can
anyone help me to see if it's correct?

(1) If "CurrDom" does not have "execute" permission on "Type" with security
class "file"(or variations), access is denied.

(2) If there is a type_transition rule says that "CurrDom" should transition
to "NewDom" after executing type "Type", then
     (2.1) If "CurrDom" does not have "transition" permission on "Type" with
security class "file" (or variations), access is denied.
     (2.2) If "NewDom" does not have "entrypoint" permission on "Type" with
security class "file" (or variations), access is denied.
     (2.3) Access is granted if both (2.1) and (2.2) are passed.

(3) There is no type_transition rules says anything about new domain for
"CurrDom" when executing "Type"
     Access is granted only when "CurrDom" has "execute_no_trans" permission
on "Type" with security class "file" (or variations).

I am not sure about following questions:
(A)  In (2), if multiple type_transition rules specify a new domain for
"CurrDom", what'll happen?
(B)  In (1), what if CurrDom has permission "execute_no_trans"?
(C)  If a process fails to transition to another domain in (2), and if
CurrDom has permission "execute_no_trans", can it execute the program and
stay in the current domain?

Is there any documentation I can refer to so I can see how the access
decision is made? Or where in the kernel source code above logic is
implement?

Thanks!

------=_Part_8224_26923091.1219955601291
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Suppose a process is in domain &quot;CurrDom&quot;.&nbsp; Now the process invokes a program with type &quot;Type&quot;.<br>Following is my understanding of whether the execution can succeed, can anyone help me to see if it&#39;s correct?<br>
<br>(1) If &quot;CurrDom&quot; does not have &quot;execute&quot; permission on &quot;Type&quot; with security class &quot;file&quot;(or variations), access is denied.<br><br>(2) If there is a type_transition rule says that &quot;CurrDom&quot; should transition to &quot;NewDom&quot; after executing type &quot;Type&quot;, then<br>
&nbsp;&nbsp;&nbsp;&nbsp; (2.1) If &quot;CurrDom&quot; does not have &quot;transition&quot; permission on &quot;Type&quot; with security class &quot;file&quot; (or variations), access is denied.<br>&nbsp;&nbsp;&nbsp;&nbsp; (2.2) If &quot;NewDom&quot; does not have &quot;entrypoint&quot; permission on &quot;Type&quot; with security class &quot;file&quot; (or variations), access is denied.<br>
&nbsp;&nbsp;&nbsp;&nbsp; (2.3) Access is granted if both (2.1) and (2.2) are passed.<br><br>(3) There is no type_transition rules says anything about new domain for &quot;CurrDom&quot; when executing &quot;Type&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp; Access is granted only when &quot;CurrDom&quot; has &quot;execute_no_trans&quot; permission on &quot;Type&quot; with security class &quot;file&quot; (or variations).<br>
<br>I am not sure about following questions:<br>(A)&nbsp; In (2), if multiple type_transition rules specify a new domain for &quot;CurrDom&quot;, what&#39;ll happen?<br>(B)&nbsp; In (1), what if CurrDom has permission &quot;execute_no_trans&quot;?<br>
(C)&nbsp; If a process fails to transition to another domain in (2), and if CurrDom has permission &quot;execute_no_trans&quot;, can it execute the program and stay in the current domain?<br><br>Is there any documentation I can refer to so I can see how the access decision is made? Or where in the kernel source code above logic is implement?<br>
<br>Thanks!<br></div>

------=_Part_8224_26923091.1219955601291--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
