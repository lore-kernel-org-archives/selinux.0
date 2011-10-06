Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p96M95v5014640
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 18:09:05 -0400
Received: from smtp.eclipse.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p96M94S4011351
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 22:09:04 GMT
Received: from monoceros.eclipse.ncsc.mil (monoceros.eclipse.ncsc.mil [144.51.102.99])
	by smtp.eclipse.ncsc.mil (Postfix) with ESMTPS id 89016184EBE
	for <selinux@tycho.nsa.gov>; Thu,  6 Oct 2011 18:09:04 -0400 (EDT)
Message-ID: <4E8E2700.70607@eclipse.ncsc.mil>
Date: Thu, 06 Oct 2011 18:09:04 -0400
From: Matt Benke <mbenke@eclipse.ncsc.mil>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Context Relabeling Authorization
Content-Type: multipart/alternative;
 boundary="------------090801030505020609070607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090801030505020609070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

All,

I'm struggling to develop a subject-to-subject information flow model 
based on "Verifying Information Flow Goals in Security-Enhanced Linux" 
but with MLS/MCS and context relabeling.  The scrawl below depicts a 
potential information flow from a source subject with context x_a that 
invokes class c_a operation p_a on object x_o to a target subject with 
context x_b that invokes class c_b operation p_b on the relabeled object 
now with context x_o' (provided that modifications resulting from 
c_a.p_a are observable via c_b.p_b):


x_a -- c_a.p_a -> x_o
                    .
                    .
                (relabel)
                    .
                    v
                   x_o' <- c_b.p_b -- x_b


To account for context relabeling requires knowing which SELinux policy 
components enforce whether a subject with context x_s = 
(u_s:r_s:t_s:m_s) is allowed to relabel an object (perhaps a subject, 
perhaps a child process, perhaps itself) instance of class k from 
context x_c = (u_c:r_c:t_c:m_c) to context x_c' = 
(u_c':r_c':t_c':m_c').  I remain ignorant, but my reading so far 
suggests that the decision depends upon:

    * whether the new context is valid
      (user, role, and type declaration and association statements),

    * whether a role transition is allowed
      (role-allow authorization statements),

    * whether the object is a subject
      (a process instance, and thus whether a domain transition or
      object transition is requested),

    * what corresponding relabeling operations are authorized
      (type-allow authorization statements), and

    * what additional constraints are in place
      ((mls)constrain and (mls)validatetrans statements)

But what source statements constrain relabeling of user and MLS/MCS 
context components, and what related basics continue to defy my limited 
comprehension, as bizarrely expressed below?

can_relabel(x_s, x_c, x_c') :
   valid(x_c') AND
   role_transition_allowed(r_c, r_c') AND
   satisfies_transition_constraints(k, x_s, x_c, x_c') AND
   (
     (
       k == 'process' AND
       x_s == x_c AND
       process_transition_allowed(x_c, x_c')
     ) OR
     (
       k =/= 'process' AND
       object_transition_allowed(k, x_s, x_c, x_c')
     )
   ) WHERE
   (
     valid(x_c') :
       (
         user_role_associated(u_c', r_c') AND
         role_type_associated(r_c', t_c') AND
         user_range_bounded(u_c', m_c')
       ) WHERE
       (
         user_role_associated(u, r) :
           ["user u roles r ..." is in the policy]
         ,
         role_type_associated(r, t) :
           ["role r types t" is in the policy]
         ,
         user_range_bounded(u, m) :
           ["user u ... range m'" is in the policy] AND
           [m is bounded by m']
       ) ,
     role_transition_allowed(r, r') :
       ["allow r r'" is in the policy]
     ,
     satisfies_transition_constraints(k, x_s, x_c, x_c') :
       [x_s, x_c, x_c' satisfy e for all "(mls)validatetrans k e" in the 
policy]
     ,
     (
       process_transition_allowed(x, x') :
         (
           operation_allowed(process.transition, x, x') AND
           EXISTS e
           (
             operation_allowed(file.execute, x, e) AND
             operation_allowed(file.entrypoint, x', e)
           )
         ) ,
       object_transition_allowed(k, s, c, c') :
         (
           operation_allowed(k.relabelfrom, s, c) AND
           operation_allowed(k'.relabelto, s, c')
         )
     ) WHERE
     (
       operation_allowed(k.p, x, x') :
       (
         ["allow t t' : k p" is in the policy] AND
         [x, x' satisfy e for all "(mls)constrain k p e" in the policy]
       )
     )
   )


--------------090801030505020609070607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    All,<br>
    <br>
    I'm struggling to develop a subject-to-subject information flow
    model based on "Verifying Information Flow Goals in
    Security-Enhanced Linux" but with MLS/MCS and context relabeling.&nbsp;
    The scrawl below depicts a potential information flow from a source
    subject with context x_a that invokes class c_a operation p_a on
    object x_o to a target subject with context x_b that invokes class
    c_b operation p_b on the relabeled object now with context x_o'
    (provided that modifications resulting from c_a.p_a are observable
    via c_b.p_b):<br>
    <br>
    <br>
    <tt>x_a -- c_a.p_a -&gt; x_o<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (relabel)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x_o' &lt;- c_b.p_b -- x_b<br>
    </tt><br>
    <br>
    To account for context relabeling requires knowing which SELinux
    policy components enforce whether a subject with context x_s =
    (u_s:r_s:t_s:m_s) is allowed to relabel an object (perhaps a
    subject, perhaps a child process, perhaps itself) instance of class
    k from context x_c = (u_c:r_c:t_c:m_c) to context x_c' =
    (u_c':r_c':t_c':m_c').&nbsp; I remain ignorant, but my reading so far
    suggests that the decision depends upon:<br>
    <ul>
      <li>whether the new context is valid<br>
        (user, role, and type declaration and association statements),<br>
        <br>
      </li>
      <li>whether a role transition is allowed<br>
        (role-allow authorization statements),<br>
        <br>
      </li>
      <li>whether the object is a subject<br>
        (a process instance, and thus whether a domain transition or
        object transition is requested),<br>
        <br>
      </li>
      <li>what corresponding relabeling operations are authorized<br>
        (type-allow authorization statements), and<br>
        <br>
      </li>
      <li>what additional constraints are in place<br>
        ((mls)constrain and (mls)validatetrans statements)<br>
      </li>
    </ul>
    But what source statements constrain relabeling of user and MLS/MCS
    context components, and what related basics continue to defy my
    limited comprehension, as bizarrely expressed below?<br>
    <br>
    can_relabel(x_s, x_c, x_c') :<br>
    &nbsp; valid(x_c') AND<br>
    &nbsp; role_transition_allowed(r_c, r_c') AND<br>
    &nbsp; satisfies_transition_constraints(k, x_s, x_c, x_c') AND<br>
    &nbsp; (<br>
    &nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k == 'process' AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x_s == x_c AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_transition_allowed(x_c, x_c')<br>
    &nbsp;&nbsp;&nbsp; ) OR <br>
    &nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k =/= 'process' AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_transition_allowed(k, x_s, x_c, x_c')<br>
    &nbsp;&nbsp;&nbsp; )<br>
    &nbsp; ) WHERE<br>
    &nbsp; ( <br>
    &nbsp;&nbsp;&nbsp; valid(x_c') :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_role_associated(u_c', r_c') AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; role_type_associated(r_c', t_c') AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_range_bounded(u_c', m_c')<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) WHERE <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_role_associated(u, r) : <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ["user u roles r ..." is in the policy]<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; role_type_associated(r, t) :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ["role r types t" is in the policy]<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_range_bounded(u, m) :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ["user u ... range m'" is in the policy] AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [m is bounded by m']<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) , <br>
    &nbsp;&nbsp;&nbsp; role_transition_allowed(r, r') : <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ["allow r r'" is in the policy]<br>
    &nbsp;&nbsp;&nbsp; ,<br>
    &nbsp;&nbsp;&nbsp; satisfies_transition_constraints(k, x_s, x_c, x_c') :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [x_s, x_c, x_c' satisfy e for all "(mls)validatetrans k e" in
    the policy]<br>
    &nbsp;&nbsp;&nbsp; ,<br>
    &nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_transition_allowed(x, x') :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(process.transition, x, x') AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EXISTS e<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(file.execute, x, e) AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(file.entrypoint, x', e)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) , <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_transition_allowed(k, s, c, c') :<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(k.relabelfrom, s, c) AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(k'.relabelto, s, c')<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
    &nbsp;&nbsp;&nbsp; ) WHERE<br>
    &nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_allowed(k.p, x, x') : <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ["allow t t' : k p" is in the policy] AND<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [x, x' satisfy e for all "(mls)constrain k p e" in the
    policy]<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
    &nbsp;&nbsp;&nbsp; )<br>
    &nbsp; )<br>
    <br>
  </body>
</html>

--------------090801030505020609070607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
