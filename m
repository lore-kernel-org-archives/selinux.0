Subject: Re: MLS directory label inheritance rules
To: Dennis Sherrell <sherrellconsulting@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 SELinux <Selinux@tycho.nsa.gov>
References: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
 <1491594062.20167.4.camel@tycho.nsa.gov>
 <1491595109.20167.6.camel@tycho.nsa.gov>
 <CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0d6424a7-eb9a-5b32-d8c6-5d5ee5419d84@schaufler-ca.com>
Date: Fri, 7 Apr 2017 13:53:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------405C9C3C57765C10EE69B6B4"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------405C9C3C57765C10EE69B6B4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 4/7/2017 1:15 PM, Dennis Sherrell wrote:
>
> In a thread ending with Nick Kravelich's contact infirmation, it was written:
>
> "
> If you write top secret data it should stay top secret even if you're writing to a folder that is normally reserved for secret data, or perhaps mixed data. Iirc it uses the MLS of the process when creating the file entry."
>
> I disagree. Top Secret data shoud not be written to a folder which was not provisioned for such. Allowing persons or processess of lower classification access to "containers" with higher clearance requirements could cause a data spill. Any thoughts as to active handling of such?
>
If you can only put TS objects in TS directories where
do you put the first TS directory? While it is generally
true that you don't want to put TS things in places that
uncleared subjects can't see them, you have to allow for
the exception of a TS directory in a less than TS directory.
Otherwise you can only have single-level filesystems.

We ran into this question way back in the Orange Book era.
Although there were several "clever" ideas put forth, the
model of allowing higher level objects to be created in
lower level directories *under controlled circumstances*
was gradually adopted as the only viable option.

> Dennis Sherrell
> Sherrell Consulting
> Bakersfield, California Company #136601
> Counter-Terrorism
> Cybernetic Countermeasure Developer
>
>
> On Fri, Apr 7, 2017, 12:55 PM Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>> wrote:
>
>     On Fri, 2017-04-07 at 15:41 -0400, Stephen Smalley wrote:
>     > On Fri, 2017-04-07 at 11:39 -0700, Nick Kralevich wrote:
>     > > When a file is created in a directory, the default label for the
>     > > file
>     > > is based on the label of the enclosing directory (unless something
>     > > like setfscreatecon is used). For example:
>     > >
>     > > bullhead:/ # cd /data/misc/zoneinfo/
>     > >
>     > > bullhead:/data/misc/zoneinfo # ls -ladZ .
>     > > drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
>     > > 1971-06-19 17:07 .
>     > > bullhead:/data/misc/zoneinfo # touch asdf
>     > > bullhead:/data/misc/zoneinfo # ls -ladZ . asdf
>     > >
>     > > drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
>     > > 2017-04-07 18:32 .
>     > > -rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
>     > > 2017-04-07 18:32 asdf
>     > >
>     > > note how the label of the "asdf" file matches the label of the
>     > > enclosing directory.
>     > >
>     > > However, that's not true when the directory uses categories. In
>     > > that
>     > > case, the newly created file inherits the label, but not the
>     > > categories. For example:
>     > >
>     > > bullhead:/data/data # cd /data/data/com.android.chrome
>     > > bullhead:/data/data/com.android.chrome # ls -ladZ .
>     > > drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
>     > > 4096
>     > > 1971-07-15 15:31 .
>     > > bullhead:/data/data/com.android.chrome # touch asdf
>     > > bullhead:/data/data/com.android.chrome # ls -laZd . asdf
>     > > drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
>     > > 4096
>     > > 2017-04-07 18:35 .
>     > > -rw-rw-rw- 1
>     > > root   root   u:object_r:app_data_file:s0              0
>     > > 2017-04-07 18:35 asdf
>     > >
>     > > Note how the label is maintained, but the "c512,c768" portion is
>     > > not
>     > > maintained. While this example occurs when I'm running in a
>     > > permissive
>     > > domain, it also occurs in an enforcing domain.
>     > >
>     > > The inconsistency seems weird, and I'm sure there's a good reason
>     > > why
>     > > this occurs that I'm not familiar with. Can someone help me
>     > > understand
>     > > if this is expected, and if so, why?
>     >
>     > First, the good news is that you get to specify which behavior you
>     > want
>     > for each context field and object class through policy (as long as
>     > your
>     > kernel and policy version supports it), see:
>     > https://selinuxproject.org/page/DefaultRules
>     >
>     > Second, there are different defaults for each of the fields of the
>     > security contexts based on what is most normative for that particular
>     > security model.  The user identity defaults to that of the creating
>     > process since we typically do not allow a process to create files
>     > with
>     > a different user identity and want the file to reflect its creator
>     > (this is defined through constraints on user identity in policies
>     > that
>     > define more than one, unlike Android). The role defaults to the fixed
>     > object_r role because originally we didn't envision a use case for
>     > roles on files.  The MLS range defaults to the low/current level of
>     > the
>     > process because a process is typically not allowed to create files at
>     > a
>     > different level and we want the file to reflect the sensitivity of
>     > the
>     > data which originated from the process. The type defaults to a
>     > related
>     > object type (in this case that of the parent directory) because
>     > process
>     > domains and object types are separate (aside from overlapping use for
>     > /proc/pid) and the relationships among them are explicit through the
>     > TE
>     > rules / access matrix rather than through implicit rules.
>     >
>     > Of course, in addition to being able to globally configure the
>     > default
>     > behavior, you can also customize specific cases through the
>     > role/type/range_transition rules.
>     >
>     > With your example above, you wanted the file to inherit the level of
>     > the directory, but consider the situation where a process with
>     > categories (:s0:c512,c768) creates a file in some shared
>     > (mlstrustedobject) directory that is just :s0.  Do you want that file
>     > to end up as just :s0?  In the MLS world, that would be a downgrade /
>     > info leak.
>
>     I guess that's not a great example since then the file would also end
>     up with the same type by default and thus would be a mlstrustedobject
>     and accessible regardless of its level.  So you'd want a type
>     transition to a derived type for files created in that directory to
>     avoid that.
>
>     _______________________________________________
>     Selinux mailing list
>     Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>.
>     To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------405C9C3C57765C10EE69B6B4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 4/7/2017 1:15 PM, Dennis Sherrell wrote:<br>
    <blockquote
cite="mid:CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com"
      type="cite">
      <p dir="ltr">In a thread ending with Nick Kravelich's contact
        infirmation, it was written:</p>
      <p dir="ltr">"<br>
        If you write top secret data it should stay top secret even if
        you're writing to a folder that is normally reserved for secret
        data, or perhaps mixed data. Iirc it uses the MLS of the process
        when creating the file entry."</p>
      <p dir="ltr">I disagree. Top Secret data shoud not be written to a
        folder which was not provisioned for such. Allowing persons or
        processess of lower classification access to "containers" with
        higher clearance requirements could cause a data spill. Any
        thoughts as to active handling of such?</p>
    </blockquote>
    <pre>
If you can only put TS objects in TS directories where
do you put the first TS directory? While it is generally
true that you don't want to put TS things in places that
uncleared subjects can't see them, you have to allow for
the exception of a TS directory in a less than TS directory.
Otherwise you can only have single-level filesystems.

We ran into this question way back in the Orange Book era.
Although there were several "clever" ideas put forth, the
model of allowing higher level objects to be created in
lower level directories *under controlled circumstances*
was gradually adopted as the only viable option.

</pre>
    <blockquote
cite="mid:CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com"
      type="cite">
      <p dir="ltr">Dennis Sherrell<br>
        Sherrell Consulting<br>
        Bakersfield, California Company #136601<br>
        Counter-Terrorism<br>
        Cybernetic Countermeasure Developer</p>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Fri, Apr 7, 2017, 12:55 PM Stephen Smalley
          &lt;<a moz-do-not-send="true" href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri,
          2017-04-07 at 15:41 -0400, Stephen Smalley wrote:<br
            class="gmail_msg">
          &gt; On Fri, 2017-04-07 at 11:39 -0700, Nick Kralevich wrote:<br
            class="gmail_msg">
          &gt; &gt; When a file is created in a directory, the default
          label for the<br class="gmail_msg">
          &gt; &gt; file<br class="gmail_msg">
          &gt; &gt; is based on the label of the enclosing directory
          (unless something<br class="gmail_msg">
          &gt; &gt; like setfscreatecon is used). For example:<br
            class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; bullhead:/ # cd /data/misc/zoneinfo/<br
            class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; bullhead:/data/misc/zoneinfo # ls -ladZ .<br
            class="gmail_msg">
          &gt; &gt; drwxrwxr-x 2 system system
          u:object_r:zoneinfo_data_<a class="moz-txt-link-freetext" href="file:s0">file:s0</a> 4096<br class="gmail_msg">
          &gt; &gt; 1971-06-19 17:07 .<br class="gmail_msg">
          &gt; &gt; bullhead:/data/misc/zoneinfo # touch asdf<br
            class="gmail_msg">
          &gt; &gt; bullhead:/data/misc/zoneinfo # ls -ladZ . asdf<br
            class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; drwxrwxr-x 2 system system
          u:object_r:zoneinfo_data_<a class="moz-txt-link-freetext" href="file:s0">file:s0</a> 4096<br class="gmail_msg">
          &gt; &gt; 2017-04-07 18:32 .<br class="gmail_msg">
          &gt; &gt; -rw-rw-rw- 1
          root   root   u:object_r:zoneinfo_data_<a class="moz-txt-link-freetext" href="file:s0">file:s0</a>    0<br
            class="gmail_msg">
          &gt; &gt; 2017-04-07 18:32 asdf<br class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; note how the label of the "asdf" file matches the
          label of the<br class="gmail_msg">
          &gt; &gt; enclosing directory.<br class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; However, that's not true when the directory uses
          categories. In<br class="gmail_msg">
          &gt; &gt; that<br class="gmail_msg">
          &gt; &gt; case, the newly created file inherits the label, but
          not the<br class="gmail_msg">
          &gt; &gt; categories. For example:<br class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; bullhead:/data/data # cd
          /data/data/com.android.chrome<br class="gmail_msg">
          &gt; &gt; bullhead:/data/data/com.android.chrome # ls -ladZ .<br
            class="gmail_msg">
          &gt; &gt; drwx------ 6 u0_a60 u0_a60
          u:object_r:app_data_<a class="moz-txt-link-freetext" href="file:s0:c512,c768">file:s0:c512,c768</a><br class="gmail_msg">
          &gt; &gt; 4096<br class="gmail_msg">
          &gt; &gt; 1971-07-15 15:31 .<br class="gmail_msg">
          &gt; &gt; bullhead:/data/data/com.android.chrome # touch asdf<br
            class="gmail_msg">
          &gt; &gt; bullhead:/data/data/com.android.chrome # ls -laZd .
          asdf<br class="gmail_msg">
          &gt; &gt; drwx------ 6 u0_a60 u0_a60
          u:object_r:app_data_<a class="moz-txt-link-freetext" href="file:s0:c512,c768">file:s0:c512,c768</a><br class="gmail_msg">
          &gt; &gt; 4096<br class="gmail_msg">
          &gt; &gt; 2017-04-07 18:35 .<br class="gmail_msg">
          &gt; &gt; -rw-rw-rw- 1<br class="gmail_msg">
          &gt; &gt;
          root   root   u:object_r:app_data_<a class="moz-txt-link-freetext" href="file:s0">file:s0</a>              0<br
            class="gmail_msg">
          &gt; &gt; 2017-04-07 18:35 asdf<br class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; Note how the label is maintained, but the
          "c512,c768" portion is<br class="gmail_msg">
          &gt; &gt; not<br class="gmail_msg">
          &gt; &gt; maintained. While this example occurs when I'm
          running in a<br class="gmail_msg">
          &gt; &gt; permissive<br class="gmail_msg">
          &gt; &gt; domain, it also occurs in an enforcing domain.<br
            class="gmail_msg">
          &gt; &gt;<br class="gmail_msg">
          &gt; &gt; The inconsistency seems weird, and I'm sure there's
          a good reason<br class="gmail_msg">
          &gt; &gt; why<br class="gmail_msg">
          &gt; &gt; this occurs that I'm not familiar with. Can someone
          help me<br class="gmail_msg">
          &gt; &gt; understand<br class="gmail_msg">
          &gt; &gt; if this is expected, and if so, why?<br
            class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; First, the good news is that you get to specify which
          behavior you<br class="gmail_msg">
          &gt; want<br class="gmail_msg">
          &gt; for each context field and object class through policy
          (as long as<br class="gmail_msg">
          &gt; your<br class="gmail_msg">
          &gt; kernel and policy version supports it), see:<br
            class="gmail_msg">
          &gt; <a moz-do-not-send="true"
            href="https://selinuxproject.org/page/DefaultRules"
            rel="noreferrer" class="gmail_msg" target="_blank">https://selinuxproject.org/page/DefaultRules</a><br
            class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; Second, there are different defaults for each of the
          fields of the<br class="gmail_msg">
          &gt; security contexts based on what is most normative for
          that particular<br class="gmail_msg">
          &gt; security model.  The user identity defaults to that of
          the creating<br class="gmail_msg">
          &gt; process since we typically do not allow a process to
          create files<br class="gmail_msg">
          &gt; with<br class="gmail_msg">
          &gt; a different user identity and want the file to reflect
          its creator<br class="gmail_msg">
          &gt; (this is defined through constraints on user identity in
          policies<br class="gmail_msg">
          &gt; that<br class="gmail_msg">
          &gt; define more than one, unlike Android). The role defaults
          to the fixed<br class="gmail_msg">
          &gt; object_r role because originally we didn't envision a use
          case for<br class="gmail_msg">
          &gt; roles on files.  The MLS range defaults to the
          low/current level of<br class="gmail_msg">
          &gt; the<br class="gmail_msg">
          &gt; process because a process is typically not allowed to
          create files at<br class="gmail_msg">
          &gt; a<br class="gmail_msg">
          &gt; different level and we want the file to reflect the
          sensitivity of<br class="gmail_msg">
          &gt; the<br class="gmail_msg">
          &gt; data which originated from the process. The type defaults
          to a<br class="gmail_msg">
          &gt; related<br class="gmail_msg">
          &gt; object type (in this case that of the parent directory)
          because<br class="gmail_msg">
          &gt; process<br class="gmail_msg">
          &gt; domains and object types are separate (aside from
          overlapping use for<br class="gmail_msg">
          &gt; /proc/pid) and the relationships among them are explicit
          through the<br class="gmail_msg">
          &gt; TE<br class="gmail_msg">
          &gt; rules / access matrix rather than through implicit rules.<br
            class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; Of course, in addition to being able to globally
          configure the<br class="gmail_msg">
          &gt; default<br class="gmail_msg">
          &gt; behavior, you can also customize specific cases through
          the<br class="gmail_msg">
          &gt; role/type/range_transition rules.<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; With your example above, you wanted the file to inherit
          the level of<br class="gmail_msg">
          &gt; the directory, but consider the situation where a process
          with<br class="gmail_msg">
          &gt; categories (:s0:c512,c768) creates a file in some shared<br
            class="gmail_msg">
          &gt; (mlstrustedobject) directory that is just :s0.  Do you
          want that file<br class="gmail_msg">
          &gt; to end up as just :s0?  In the MLS world, that would be a
          downgrade /<br class="gmail_msg">
          &gt; info leak.<br class="gmail_msg">
          <br class="gmail_msg">
          I guess that's not a great example since then the file would
          also end<br class="gmail_msg">
          up with the same type by default and thus would be a
          mlstrustedobject<br class="gmail_msg">
          and accessible regardless of its level.  So you'd want a type<br
            class="gmail_msg">
          transition to a derived type for files created in that
          directory to<br class="gmail_msg">
          avoid that.<br class="gmail_msg">
          <br class="gmail_msg">
          _______________________________________________<br
            class="gmail_msg">
          Selinux mailing list<br class="gmail_msg">
          <a moz-do-not-send="true" href="mailto:Selinux@tycho.nsa.gov"
            class="gmail_msg" target="_blank">Selinux@tycho.nsa.gov</a><br
            class="gmail_msg">
          To unsubscribe, send email to <a moz-do-not-send="true"
            href="mailto:Selinux-leave@tycho.nsa.gov" class="gmail_msg"
            target="_blank">Selinux-leave@tycho.nsa.gov</a>.<br
            class="gmail_msg">
          To get help, send an email containing "help" to <a
            moz-do-not-send="true"
            href="mailto:Selinux-request@tycho.nsa.gov"
            class="gmail_msg" target="_blank">Selinux-request@tycho.nsa.gov</a>.</blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------405C9C3C57765C10EE69B6B4--
