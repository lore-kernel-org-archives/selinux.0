Message-ID: <4AC4A6D9.6080305@manicmethod.com>
Date: Thu, 01 Oct 2009 08:55:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>	 <4AC2C32D.3010405@ak.jp.nec.com>	 <1254314361.30591.11.camel@moss-pluto.epoch.ncsc.mil>	 <1254315215.30591.18.camel@moss-pluto.epoch.ncsc.mil>	 <alpine.LRH.2.00.0910010745180.30576@tundra.namei.org> <1254400360.30591.105.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254400360.30591.105.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------030503010808050900090307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030503010808050900090307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Stephen Smalley wrote:
> On Thu, 2009-10-01 at 07:46 +1000, James Morris wrote:
>    
>> On Wed, 30 Sep 2009, Stephen Smalley wrote:
>>
>>      
>>> Does anyone think we still need to support policy versions<
>>> POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
>>> dynamic remapping of netlink classes in the security server:
>>>          if (policydb_loaded_version<  POLICYDB_VERSION_NLCLASS)
>>>                  if (tclass>= SECCLASS_NETLINK_ROUTE_SOCKET&&
>>>                      tclass<= SECCLASS_NETLINK_DNRT_SOCKET)
>>>                          tclass = SECCLASS_NETLINK_SOCKET;
>>>
>>> I think RHEL4 shipped with policy.18.
>>>        
>> Was any distro shipped with a lower policy version?  If not, then I think
>> it should be ok.
>>      
>
> policy.18 was first supported by Linux 2.6.8.
> I think the only distro to ship with SELinux enabled and Linux<  2.6.8
> would have been Fedora Core 2, which is long since EOL'd and even akpm
> doesn't run it anymore.  Not sure about Hardened Gentoo - Chris and/or
> Joshua?  Debian selinux packages predated Fedora, of course, but weren't
> mainstreamed into Debian until much later.
>
> I didn't yet remove this logic in my patches, but will do so if there
> are no objections.
>
>    

I don't think it matters, the only case where this would come up is if 
you updated your kernel to 2.6.33 and didn't rebuild your policy right? 
I just don't see that happening really.

--------------030503010808050900090307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Stephen Smalley wrote:
<blockquote
 cite="mid:1254400360.30591.105.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Thu, 2009-10-01 at 07:46 +1000, James Morris wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Wed, 30 Sep 2009, Stephen Smalley wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Does anyone think we still need to support policy versions &lt;
POLICYDB_VERSION_NLCLASS (18)?  If not, then we can just drop the
dynamic remapping of netlink classes in the security server:
        if (policydb_loaded_version &lt; POLICYDB_VERSION_NLCLASS)
                if (tclass &gt;= SECCLASS_NETLINK_ROUTE_SOCKET &amp;&amp;
                    tclass &lt;= SECCLASS_NETLINK_DNRT_SOCKET)
                        tclass = SECCLASS_NETLINK_SOCKET;

I think RHEL4 shipped with policy.18.
      </pre>
    </blockquote>
    <pre wrap="">Was any distro shipped with a lower policy version?  If not, then I think 
it should be ok.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
policy.18 was first supported by Linux 2.6.8.
I think the only distro to ship with SELinux enabled and Linux &lt; 2.6.8
would have been Fedora Core 2, which is long since EOL'd and even akpm
doesn't run it anymore.  Not sure about Hardened Gentoo - Chris and/or
Joshua?  Debian selinux packages predated Fedora, of course, but weren't
mainstreamed into Debian until much later.

I didn't yet remove this logic in my patches, but will do so if there
are no objections.

  </pre>
</blockquote>
<br>
I don't think it matters, the only case where this would come up is if
you updated your kernel to 2.6.33 and didn't rebuild your policy right?
I just don't see that happening really.<br>
</body>
</html>

--------------030503010808050900090307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
