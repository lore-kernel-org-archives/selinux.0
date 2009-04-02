MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_m42wBzYZJJdNPgTGuTGcyA)"
Date: Thu, 02 Apr 2009 16:43:17 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
In-reply-to: <20090401175012.GF9992@Sun.COM>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Message-id: <49D54D95.2080009@sun.com>
References: <1238160162.15207.19.camel@localhost.localdomain>
 <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM>
 <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain>
 <49D10FC1.3000103@sun.com> <1238447664.2484.119.camel@localhost.localdomain>
 <49D1B133.3010907@sun.com> <20090331182851.GG9992@Sun.COM>
 <49D2E073.3060003@sun.com> <20090401175012.GF9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_m42wBzYZJJdNPgTGuTGcyA)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

On 04/01/09 10:50, Nicolas Williams wrote:
> On Tue, Mar 31, 2009 at 08:33:07PM -0700, Jarrett Lu wrote:
>   
>> Nicolas Williams wrote:
>>     
>>> On Mon, Mar 30, 2009 at 10:59:15PM -0700, Jarrett Lu wrote:
>>>  
>>>       
>>>> That's certainly one option. We can say DOI + an opaque field is what we 
>>>> will add to NFSv4 protocol. Use the information as you see fit. Going 
>>>>    
>>>>         
>>> That's what David's I-D and what my RPCSEC_GSSv3 I-D both say now.
>>>  
>>>       
>> If we stop here, we don't have much of an interoperability story. I 
>>     
>
> I don't agree.  We'd have the same interop story everyone has today
> w.r.t. labeling: synchronization of policies is an out-of-band, manual
> (automatable) task; no standard protocol nor policy description
> language is specified.
>   

I don't mean to dwell on this. Requiring either systems being identical 
or relying on OOB information to know whether the opaque field can be 
used sounds weak on interoperability.  ;-)

I agree with you on rest of your comments. I still think more detailed 
study on different use cases are needed to understand whether the 
proposed solutions are suitable, sufficient, etc..

Jarrett


--Boundary_(ID_m42wBzYZJJdNPgTGuTGcyA)
Content-type: text/html; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 04/01/09 10:50, Nicolas Williams wrote:
<blockquote cite="mid:20090401175012.GF9992@Sun.COM" type="cite">
  <pre wrap="">On Tue, Mar 31, 2009 at 08:33:07PM -0700, Jarrett Lu wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Nicolas Williams wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Mon, Mar 30, 2009 at 10:59:15PM -0700, Jarrett Lu wrote:
 
      </pre>
      <blockquote type="cite">
        <pre wrap="">That's certainly one option. We can say DOI + an opaque field is what we 
will add to NFSv4 protocol. Use the information as you see fit. Going 
   
        </pre>
      </blockquote>
      <pre wrap="">That's what David's I-D and what my RPCSEC_GSSv3 I-D both say now.
 
      </pre>
    </blockquote>
    <pre wrap="">If we stop here, we don't have much of an interoperability story. I 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't agree.  We'd have the same interop story everyone has today
w.r.t. labeling: synchronization of policies is an out-of-band, manual
(automatable) task; no standard protocol nor policy description
language is specified.
  </pre>
</blockquote>
<br>
I don't mean to dwell on this. Requiring either systems being identical
or relying on OOB information to know whether the opaque field can be
used sounds weak on interoperability.&nbsp; ;-)<br>
<br>
I agree with you on rest of your comments. I still think more detailed
study on different use cases are needed to understand whether the
proposed solutions are suitable, sufficient, etc..<br>
<br>
Jarrett<br>
<br>
</body>
</html>

--Boundary_(ID_m42wBzYZJJdNPgTGuTGcyA)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
