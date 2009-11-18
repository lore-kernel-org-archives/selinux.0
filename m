Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAI2kIAh012532
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 21:46:18 -0500
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAI2mLGY029741
	for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2009 02:48:22 GMT
Message-ID: <4B035FA4.6080605@ak.jp.nec.com>
Date: Wed, 18 Nov 2009 11:44:52 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Jacques Thomas <jthomas@cs.purdue.edu>
CC: SE Linux <selinux@tycho.nsa.gov>, method@manicmethod.com
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu>
In-Reply-To: <4AF71B05.8030707@cs.purdue.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry for the late response due to my extreme busy days on the last week.

Jacques Thomas wrote:
> Hi All,
> 
> I am trying to document the semantics of bounded types, and I am puzzled 
> by two things:
> 
> 
> 1/ The rationale for type boundaries on *target* types
> I understand type boundaries on source types: the idea is that, if typeA 
> is bounded by typeB, then typeA can not exert more permissions than 
> typeB. This would be declared with the following statement in the source 
> policy:
> TYPEBOUND typeB typeA
> 
> What is a good use case for type boundaries on target types ?

If a target type (parent) has a few bounded types (children), we can use
the parent as a shared resource, and children as private types for individual
source types.

For example, please assume httpd_user_content_t and httpd_guest_content_t
are bounded by httpd_sys_content_t. In this example, a domain which tries
to access to the httpd_user_content_t must have a set of equal or wider
permissions on the httpd_sys_content_t. Ditto for httpd_guest_content_t.
If here are two domains ( user_webapp_t and guest_webapp_t ) with its own
private types individually, we can use the boundaries to restrict permissions
to be allowed on the child types.

However, we have to admit it is a bit hard to image actual use cases.
In fact, we can apply same restriction using regular types.

Joshua, do you have any idea for use cases of boundaries in targets?


> 2/ The logic of type_attribute_bounds_av in ss/services.c (kernel side)
> This method is invoked to filter/limit an access vector according to the 
> type boundaries. Its logic goes as follows:
> 
> if(source type has a bound){  // SOURCE
>    ../..
>    if(the bound is not violated)
>        return
>    ../..
> }
> 
> if(target type has a bound){  // TARGET
>    ../..
>    if(the bound is not violated)
>       return
>    ../..
> }
> 
> if(target and source types have a bound){ // BOTH
>    ../..
>    if(these bounds are not violated)
>       return
>    ../..
> }
> 
> if(there was a violation){
>    send audit message to user space
> }
> 
> The early return statements seem to violate the intent of the code. For 
> instance, suppose that the source type is bounded and no access bits 
> violates these bounds, then the code will never evaluate whether bounds 
> on the target type are violated.
> 
> It seems to me that the logic should be:
> 
> // BOTH
> else // SOURCE
> else // TARGET
> 
> Instead of:
> 
> // SOURCE
> // TARGET
> // BOTH

Assume P(s,t) means a set of permissions allowed between 's' and 't'.
Assume 'Sc' is bounded by 'Sp', and 'Tc' is bounded by 'Tp'.

In this case,
- P(Sc,Tp) should be equal or less than P(Sp,Tp) due to the SOURCE check.
- P(Sp,Tc) should be equal or less than P(Sp,Tp) due to the TARGET check.
- P(Sc,Tc) should be equal or less than P(Sp,Tp) due to the BOTH check,
  and should P(Sc,Tc) equal to (P(Sc,Tp) AND P(Sp,Tc)).

However, the current implementation immediately returns when no violations
between P(Sc,Tp) and P(Sp,Tp) on the SOURCE check, even if both of types
have its boundaries. The P(Sc,Tc) should be also masked by P(Sc,Tp), but
it seems to me being bypassed.

If my logic is not incorrect, the implementation should be fixed as follows:

  type_attribute_bounds_av(Sc,Tc, ...)
  {
    masked = 0;

    if (Sc has its bounds)
      masked |= P(Sc,Tc) & ~P(Sp,Tc);

    if (Tc has its bounds)
      masked |= P(Sc,Tc) & ~P(Sc,Tp);

    avd->allowed &= ~masked;
  }

Any comments?

I also think we have one other a rough option.
It simply applies type boundaries on only sources to restrict its privileges,
and it does not apply any restrictions on target types.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
