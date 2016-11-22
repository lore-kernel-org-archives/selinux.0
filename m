Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMIrCIl031426
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 13:53:12 -0500
Received: by mail-oi0-f45.google.com with SMTP id y198so28259648oia.1
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 10:53:09 -0800 (PST)
Subject: Re: [PATCH] Fix AUDIT_MAC_POLICY_LOAD event formatting
To: selinux@tycho.nsa.gov, linux-audit@redhat.com
References: <11128714.mipGzmS50p@x2>
 <CAHC9VhSYkymKzvbOW1vkZ_Ae=VGZc8TcMKimyXO0iO7e6M8GzQ@mail.gmail.com>
 <0839aedc-39b9-7345-9cf7-606538204c9c@tycho.nsa.gov> <67267460.FCN7LuPZon@x2>
 <1be21bc4-e70f-092f-13cb-458cc0beefad@tycho.nsa.gov>
From: Lenny Bruzenak <lenny@magitekltd.com>
Message-ID: <d9a25cdc-0c3c-755a-d82d-4af2b866b65e@magitekltd.com>
Date: Tue, 22 Nov 2016 12:53:05 -0600
MIME-Version: 1.0
In-Reply-To: <1be21bc4-e70f-092f-13cb-458cc0beefad@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="------------839145B3E34ADB6CB7E074CC"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------839145B3E34ADB6CB7E074CC
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/2016 08:55 AM, Stephen Smalley wrote:

>> >OK. We can move the point where res=1 is set. But I would think that its a
>> >requirement to have an audit record that states that policy failed to load.
>> >FMT_MSA.3 Static Attribute Initialization. Auditable events: All modifications
>> >of the initial value of security attributes. I would think this means changes
>> >such as booleans, modifying labels, loading a new policy, or failure to load a
>> >policy.
> Failure to load a policy is not a modification to the initial value of
> the security attribute, is it?
>
It is definitely relevant, if it falls under another category.
Either a failed malicious intent or a failed supervisory function.

LCB

--------------839145B3E34ADB6CB7E074CC
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>On 11/22/2016 08:55 AM, Stephen Smalley wrote:<br>
    </p>
    <blockquote
      cite="mid:1be21bc4-e70f-092f-13cb-458cc0beefad@tycho.nsa.gov"
      type="cite">
      <blockquote type="cite" style="color: #000000;">
        <pre wrap=""><span class="moz-txt-citetags">&gt; </span>OK. We can move the point where res=1 is set. But I would think that its a 
<span class="moz-txt-citetags">&gt; </span>requirement to have an audit record that states that policy failed to load. 
<span class="moz-txt-citetags">&gt; </span>FMT_MSA.3 Static Attribute Initialization. Auditable events: All modifications 
<span class="moz-txt-citetags">&gt; </span>of the initial value of security attributes. I would think this means changes 
<span class="moz-txt-citetags">&gt; </span>such as booleans, modifying labels, loading a new policy, or failure to load a 
<span class="moz-txt-citetags">&gt; </span>policy.
</pre>
      </blockquote>
      <pre wrap="">Failure to load a policy is not a modification to the initial value of
the security attribute, is it?

</pre>
    </blockquote>
    It is definitely relevant, if it falls under another category.<br>
    Either a failed malicious intent or a failed supervisory function.<br>
    <br>
    LCB<br>
  </body>
</html>

--------------839145B3E34ADB6CB7E074CC--
