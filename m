Message-ID: <4A4CB8C1.5040403@redhat.com>
Date: Thu, 02 Jul 2009 09:40:17 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [Patch 1/2] libsemanage: remember and retrieve dontaudit settings
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C175A.2090100@redhat.com> <1246538351.13464.268.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246538351.13464.268.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------040007020000070703090008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040007020000070703090008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2009 08:39 AM, Stephen Smalley wrote:
> On Wed, 2009-07-01 at 22:11 -0400, Christopher Pardy wrote:
>    
>> On 07/01/2009 10:08 PM, Christopher Pardy wrote:
>>      
>>> This is a heavily modified version of the patch I recently submitted.
>>> It provides 3 new functions: in libsepol sepol_get_disable_dontaudit;
>>> in libsemanage semanage_get_disable_dontaudit; in libselinux
>>> is_dontaudit_disabled. It also fixes issues with the previous patch.
>>>
>>> The justification for this patch is the same as the one I posted
>>> earlier. Simply, there is currently no way to know if dontaudit rules
>>> are  enabled. Additionally once don't audit rules are turned they turn
>>> themselves off after policy rebuild (is that the desired
>>> functionality?) This patch provides  a way to check on both the
>>> current and pending state of the dontaudit rules and it maintains this
>>> state between policy rebuilds.
>>>
>>> Signed-off-by Christopher Pardy<cpardy@redhat.com>
>>>        
>> Patch 1 implements libsepol function. Including inline and attaching in
>> case thunderbird messes up tabs.
>>      
>
> It did.  But allegedly one can configure it to work, e.g. read:
> http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt
>
>    
>> diff -urN selinux.orig/libsepol/include/sepol/handle.h
>> selinux/libsepol/include/sepol/handle.h
>> --- selinux.orig/libsepol/include/sepol/handle.h    2009-07-01
>> 21:05:26.823235749 -0400
>> +++ selinux/libsepol/include/sepol/handle.h    2009-07-01
>> 21:08:33.277237031 -0400
>> @@ -7,6 +7,12 @@
>>    /* Create and return a sepol handle. */
>>    sepol_handle_t *sepol_handle_create(void);
>>
>> +/* Get whether or not dontaudits will be disabled, same values as
>> + * specified by disable dont audit. This value reflects the state
>> + * your system will be set to upon commit, not nessesarily it's
>> + * current state.*/
>> +int sepol_get_disable_dontaudit(sepol_handle_t * sh);
>>      
>
> I don't understand why we would export this, as it is a transient
> setting only meaningful within a transaction and the caller should know
> whether or not he has set or cleared it already.
>
>    
Yes the caller should know, this patch simply provides function symmetry 
between get and set functions. It also allows the other part of this 
patch to actually work as the caller might not know what the value has 
been set to by default. Also although we assume the caller has 
remembered when using the terminal commands when programs are modifying 
this value it seems redundant to force them to store a flag when the 
ability to read the flag in the handle is so trivial.
>> +
>>    /* Set whether or not to disable dontaudits, 0 is default and does
>>     * not disable dontaudits, 1 disables them */
>>    void sepol_set_disable_dontaudit(sepol_handle_t * sh, int
>> disable_dontaudit);
>> diff -urN selinux.orig/libsepol/src/handle.c selinux/libsepol/src/handle.c
>> --- selinux.orig/libsepol/src/handle.c    2009-07-01 21:05:26.854236864
>> -0400
>> +++ selinux/libsepol/src/handle.c    2009-07-01 21:07:15.532236991 -0400
>> @@ -21,6 +21,12 @@
>>        return sh;
>>    }
>>
>> +int sepol_get_disable_dontaudit(sepol_handle_t *sh)
>> +{
>> +    assert(sh !=NULL);
>> +    return sh->disable_dontaudit;
>> +}
>> +
>>    void sepol_set_disable_dontaudit(sepol_handle_t * sh, int
>> disable_dontaudit)
>>    {
>>        assert(sh !=NULL);
>> diff -urN selinux.orig/libsepol/src/libsepol.map
>> selinux/libsepol/src/libsepol.map
>> --- selinux.orig/libsepol/src/libsepol.map    2009-07-01
>> 21:05:26.848236011 -0400
>> +++ selinux/libsepol/src/libsepol.map    2009-07-01 21:07:45.948485729 -0400
>> @@ -12,6 +12,7 @@
>>        sepol_policydb_*; sepol_set_policydb_from_file;
>>        sepol_policy_kern_*;
>>        sepol_policy_file_*;
>> +    sepol_get_disable_dontaudit;
>>        sepol_set_disable_dontaudit;
>>        sepol_set_expand_consume_base;
>>      local: *;
>>      

--------------040007020000070703090008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 07/02/2009 08:39 AM, Stephen Smalley wrote:
<blockquote
 cite="mid:1246538351.13464.268.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Wed, 2009-07-01 at 22:11 -0400, Christopher Pardy wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On 07/01/2009 10:08 PM, Christopher Pardy wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">This is a heavily modified version of the patch I recently submitted. 
It provides 3 new functions: in libsepol sepol_get_disable_dontaudit; 
in libsemanage semanage_get_disable_dontaudit; in libselinux 
is_dontaudit_disabled. It also fixes issues with the previous patch.

The justification for this patch is the same as the one I posted 
earlier. Simply, there is currently no way to know if dontaudit rules 
are  enabled. Additionally once don't audit rules are turned they turn 
themselves off after policy rebuild (is that the desired 
functionality?) This patch provides  a way to check on both the 
current and pending state of the dontaudit rules and it maintains this 
state between policy rebuilds.

Signed-off-by Christopher Pardy <a class="moz-txt-link-rfc2396E" href="mailto:cpardy@redhat.com">&lt;cpardy@redhat.com&gt;</a>
      </pre>
    </blockquote>
    <pre wrap="">Patch 1 implements libsepol function. Including inline and attaching in 
case thunderbird messes up tabs.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It did.  But allegedly one can configure it to work, e.g. read:
<a class="moz-txt-link-freetext" href="http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt">http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt</a>

  </pre>
  <blockquote type="cite">
    <pre wrap="">diff -urN selinux.orig/libsepol/include/sepol/handle.h 
selinux/libsepol/include/sepol/handle.h
--- selinux.orig/libsepol/include/sepol/handle.h    2009-07-01 
21:05:26.823235749 -0400
+++ selinux/libsepol/include/sepol/handle.h    2009-07-01 
21:08:33.277237031 -0400
@@ -7,6 +7,12 @@
  /* Create and return a sepol handle. */
  sepol_handle_t *sepol_handle_create(void);

+/* Get whether or not dontaudits will be disabled, same values as
+ * specified by disable dont audit. This value reflects the state
+ * your system will be set to upon commit, not nessesarily it's
+ * current state.*/
+int sepol_get_disable_dontaudit(sepol_handle_t * sh);
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't understand why we would export this, as it is a transient
setting only meaningful within a transaction and the caller should know
whether or not he has set or cleared it already.

  </pre>
</blockquote>
Yes the caller should know, this patch simply provides function
symmetry between get and set functions. It also allows the other part
of this patch to actually work as the caller might not know what the
value has been set to by default. Also although we assume the caller
has remembered when using the terminal commands when programs are
modifying this value it seems redundant to force them to store a flag
when the ability to read the flag in the handle is so trivial.<br>
<blockquote
 cite="mid:1246538351.13464.268.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+
  /* Set whether or not to disable dontaudits, 0 is default and does
   * not disable dontaudits, 1 disables them */
  void sepol_set_disable_dontaudit(sepol_handle_t * sh, int 
disable_dontaudit);
diff -urN selinux.orig/libsepol/src/handle.c selinux/libsepol/src/handle.c
--- selinux.orig/libsepol/src/handle.c    2009-07-01 21:05:26.854236864 
-0400
+++ selinux/libsepol/src/handle.c    2009-07-01 21:07:15.532236991 -0400
@@ -21,6 +21,12 @@
      return sh;
  }

+int sepol_get_disable_dontaudit(sepol_handle_t *sh)
+{
+    assert(sh !=NULL);
+    return sh-&gt;disable_dontaudit;
+}
+
  void sepol_set_disable_dontaudit(sepol_handle_t * sh, int 
disable_dontaudit)
  {
      assert(sh !=NULL);
diff -urN selinux.orig/libsepol/src/libsepol.map 
selinux/libsepol/src/libsepol.map
--- selinux.orig/libsepol/src/libsepol.map    2009-07-01 
21:05:26.848236011 -0400
+++ selinux/libsepol/src/libsepol.map    2009-07-01 21:07:45.948485729 -0400
@@ -12,6 +12,7 @@
      sepol_policydb_*; sepol_set_policydb_from_file;
      sepol_policy_kern_*;
      sepol_policy_file_*;
+    sepol_get_disable_dontaudit;
      sepol_set_disable_dontaudit;
      sepol_set_expand_consume_base;
    local: *;
    </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------040007020000070703090008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
