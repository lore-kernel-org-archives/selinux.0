Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA21747
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:29:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA00376
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 19:28:04 GMT
Received: from rameses.restarea.ncsc.mil (rameses.restarea.ncsc.mil [144.51.79.100])
        by jazzband.ncsc.mil  with ESMTP id TAA00372 for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 19:28:03 GMT
Received: from rameses.restarea.ncsc.mil (root@localhost)
	by rameses.restarea.ncsc.mil with ESMTP id g4OJT6S20967
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:29:06 -0400 (EDT)
Received: from lancer.restarea.ncsc.mil (lancer.restarea.ncsc.mil [144.51.134.113])
	by rameses.restarea.ncsc.mil with ESMTP id g4OJT6E20963
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:29:06 -0400 (EDT)
Message-ID: <3CEE948F.AF44A7D5@restarea.ncsc.mil>
Date: Fri, 24 May 2002 15:29:19 -0400
From: Patrick Henry <phenry@restarea.ncsc.mil>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Natural representation of policy.conf structures...?
Content-Type: multipart/mixed;
 boundary="------------292F2596F898F5ADA3B0DCCE"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------292F2596F898F5ADA3B0DCCE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Going with the current flow of dealing with policy.conf
directly, it seems to me that analysis of this file requires
some way of recovering a natural structuring of the data within
this file. I'm not suggesting that the structure within the
original pre-compiled files is at all natural, just that if this
information is to be displayed to the user in a meaningful way,
listing the attributes for a single selected item is not sufficient.

Just like industrial plant processes often benefit from a large
display wall showing all the process components with status lights,
security should benefit from having an easily-readable, color-coded
display showing all the relevant attributes in one place.
Of course it's not a trivial matter to do this, so I thought I'd
throw out a few ideas...


The first few structures seem easy enough to represent as lists:

"common": one line per entry, with color-coded common_name (for
          use in class list) and attributes listed afterwards.

"class":  one line per entry, first class_name, then color-coded
          common_name from "inherit" line if present, then
          a list of attributes.

"role":   one line per role, role_name followed by color-coded
          domains, so you can easily spot similarities between roles.

"type":   as per "role" with an added "alias" column.

>From here on in, it gets tricky.

The allow, auditallow, auditdeny, deny(=lack of allow or auditdeny)
and neverallow states suggest a color-scheme of green, yellow,
orange and red, and then greyed/lighter versions of these for states
also covered by a neverallow rule. Or whatever. Anyway...

Implementing that for "RBAC allow" rules doesn't seem too difficult,
and is probably even a little overkill given the typical number (<10)
of rules and the fact that there are only two color-states. A matrix
containing the entire roles namespace on columns and rows is still
small enough to be easily viewed, perhaps on the same page as the
"roles" list above.

"TE allow" is a bit more tricky. Representing nearly 20k allow rules
(some with wildcards) and 20 neverallow rules (all with wildcards),
is hard enough. Showing all 5 variables in a table is even harder.
The simplest representation I can think of is to have the types
namespace (or that subset of it which is used in these rules) as
columns and rows, to have the allow/deny/etc state represented by
color as described earlier, and the table entry contain the
remaining 2 variables as text: "object_class(es) permissions"
One problem here is that the table would probably need multiple
lines (each perhaps with different color) within a table cell, which
can be confusing. Another problem is that such a table would be too
large to be of any real value.

"type_transition" suffers from similar problems. A potentially
useful representation has a table with the type namespace as columns
and rows - for "source" and "default" entries. If there are multiple
"sources" in a rule, they are expanded out. The table cells are then
"catalyst_type(s):catalyst_object(s)"
Again, we may have multiple lines per table entry, and the table
itself is huge - but nothing compared to "TE allow."

While I haven't tried to represent the "TE allow" rules as a table,
I have done so for "type_transition," and it turns out that this is
a very sparse matrix containing lots of small dense sub-matrices.
If we run an algorithm to find and isolate these smaller matrices
(with other entries perhaps in a "misc" list) then we would end up
with small, useful tables representing atomic units. Analysis of
these can be done almost in isolation. It's not at all clear that
we can do this with "TE allow"...does anybody have any ideas on this?

As a demonstator to show the sort of things I'm talking about, I've
attached a quick and dirty awk script which takes in policy.conf and
generates a few of these tables as HTML files. This is by no means a
solution - it's pretty ugly, for a start, and it seems sensible to use
libapol now that it's available - but I'm hoping that by the time I
get back in a week's time at least somebody will have some ideas on
the subject.

Thoughts, anyone?

Patrick

--Give me liberty, or give me chocolate--
--------------292F2596F898F5ADA3B0DCCE
Content-Type: text/plain; charset=us-ascii;
 name="policy2html"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy2html"

#!/usr/bin/awk -f

# This code is distributed under the terms of
# the GNU GPL, v.1 - available at:
# http://www.gnu.org/copyleft/copying-1.0.html
# As usual, there is no warranty - should this
# script cause your pet fish to jump out of the
# tank and eat you, that's your problem...

# Functions - the real meat of the script

function error_exit(num,string)
{
  printf(string) > "/dev/stderr";
  exit(num);
}

# ----------------------------------------
# HTML display functions
# ----------------------------------------

function header(section,file) {
  printf("<html><head><title>Parsing of Policy File [%s] by %s: %s</title>\n</head><body>\n",FILENAME,me_version,section) > file;
}

function footer(file) {
  printf("<hr></body></html>\n") > file;
}


# ----------------------------------------
# This automatically tracks previously assigned colors
# with an array, and assign new ones as required, so that
# everything in the namespace has an unique bgcolor.
# Prettier colors would be nice!

function get_bgcolor(name_string)
{
#  return "white";
  if ( initialized_bgcolor == 0 )
  {
    cols_i=0;
    cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",79,79,79);
    for(i=95;i<256;i+=16)
    {
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",i ,i ,i );
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",i ,i ,79);
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",i ,79,i );
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",79,i ,i );
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",i ,79,79);
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",79,i ,79);
      cols_a[cols_i++]=sprintf("\"#%.2x%.2x%.2x\"",79,79,i );
    }
    cols_j=0;
    initialized_bgcolor=1;
  }
  if (bgcolor_a[name_string] == "")
  {
    bgcolor_a[name_string]=cols_a[cols_j++];
    if (cols_j >= cols_i)
    {
      cols_j=0;
      printf("Colors wrapped around\n") > "/dev/stderr";
    }
  }
  return bgcolor_a[name_string];
}

# ----------------------------------------
# Functions manipulating table cells
# ----------------------------------------

function get_one_cell(content,bgcolor)
{
  if (bgcolor == "")
    bgcolor=get_bgcolor(content);
  return sprintf("<td bgcolor=%s>%s</td>",bgcolor,content);
}

# ----------------------------------------

function add_one_cell(starter,content,bgcolor, addition)
{
  if (content == "}" || content == "#" || content=="")
    return starter;
  addition=get_one_cell(content,bgcolor);
  if (index(starter,addition) == 0)
    return sprintf("%s%s",starter,addition);
  else
    return starter;
}

# ----------------------------------------

function get_cells_one_line(retstr, i,j)
{
  j=0;
  for(i=1;i<NF;i++)
    if ($i == "{") j=i;
  if (j == 0) return add_one_cell(retstr,substr($NF,1,length($NF)-1));
  if ($NF == "};")
    for(i=j+1;i<NF;i++)
      retstr=add_one_cell(retstr,$i);
  else
    error_exit(-1,"Unhandled condition in get_cells_one_line");
  return retstr;
}

# ----------------------------------------

function get_multiline(array_a,bgcolor, my_multiline)
{
  my_multiline="";
  if ($1 == "inherits")
  {
    my_multiline=get_one_cell($2);
    getline;
  }
  if ($1 == "{")
  {
    do {
      getline;
      my_multiline=add_one_cell(my_multiline,$1,bgcolor);
    } while ($NF != "}");
  }
  return my_multiline;
}

# ----------------------------------------
# Top-level display functions
# ----------------------------------------
function display_roles(file)
{
  header("Roles List",file);

  # Possibly put a colspan in for the second header, have max entries per line.
  printf("<hr><h1>Roles List</h1>\n<table border=1><tr><th bgcolor=\"#99ccff\">Role Name</th><th bgcolor=\"#99ccff\">Allowed Types</th></tr>\n") > file;
  for (role in role_a)
  {
    printf("<tr><td>%s</td>%s</tr>\n",role,role_a[role]) > file;
  }
  printf("</table>\n") > file;
  footer(file);
}
# ----------------------------------------
function display_classes(file)
{
  header("Classes List",file);

  # Possibly put a colspan in for the second header, have max entries per line.
  printf("<hr><h1>Classes List</h1>\n<table border=1><tr><th bgcolor=\"#99ccff\">Class Name</th><th bgcolor=\"#99ccff\">Attributes</th></tr>\n") > file;
  for (class in class_a)
  {
    printf("<tr><td>%s</td>%s</tr>\n",class,class_a[class]) > file;
  }
  printf("</table>\n") > file;
  footer(file);
}
# ----------------------------------------
function display_commons(file)
{
  header("Commons List",file);

  # Possibly put a colspan in for the second header, have max entries per line.
  printf("<hr><h1>Commons List</h1>\n<table border=1><tr><th bgcolor=\"#99ccff\">Common Name</th><th bgcolor=\"#99ccff\">Attributes</th></tr>\n") > file;
  for (common in common_a)
  {
    printf("<tr><td>%s</td>%s</tr>\n",common,common_a[common]) > file;
  }
  printf("</table>\n") > file;
  footer(file);
}
# ----------------------------------------
function display_types(file)
{
  header("Types List",file);

  # Possibly put a colspan in for the second header, have max entries per line.
  printf("<hr><h1>Types List</h1>\n<table border=1><tr><th bgcolor=\"#99ccff\">Type Name</th><th bgcolor=\"#99ccff\">Alias Name</th><th bgcolor=\"#99ccff\">Attributes</th></tr>\n") > file;
  for (type in type_a)
  {
    printf("<tr><td>%s</td><td bgcolor=\"#99ccff\">%s</td>%s</tr>\n",type,type_alias_a[type],type_a[type]) > file;
  }
  printf("</table>\n") > file;
  footer(file);
}
# ----------------------------------------
function display_type_transitions(file, type_i,type_j)
{
  header("Type Transitions Matrix",file);
  # This section consists of lots of small dense matrices
  # within a large sparse one. It would be better to find
  # the dense matrices, but I can't be bothered right now!
  printf("<hr><h1>Type Transitions Matrix</h1>\n<table border=1><tr><th bgcolor=white>From\\To</th>\n") > file;
  for(type_j in type_to_a)
    printf("<th bgcolor=\"#99ccff\">%s</th>",type_j) > file;
  printf("</tr>\n") > file;
  for(type_i in type_from_a)
  {
    printf("<tr><th bgcolor=\"#99ccff\">%s</th>",type_i) > file;
    for(type_j in type_to_a)
      printf("<td>%s</td>",type_transition_a[type_i,type_j]) > file;
    printf("</tr>\n") > file;
  }
  printf("</table>\n") > file;
  footer(file);
}
# ----------------------------------------



# ----------------------------------------
# Begin - set up global variables
# ----------------------------------------
BEGIN {
  me_version="policy2html v0.01";
  initialized_bgcolor=0;

}


# ----------------------------------------
# Main program - collect data
# ----------------------------------------
{
  if ($1 != "#")
  {
    if (next_maybe_class_multiline == 1)
    {
      class_multiline=get_multiline(common_a,"white");
      
      if (class_multiline != "")
        class_a[next_class]=class_multiline;

      next_maybe_class_multiline=0;
    }
    if (next_maybe_common_multiline == 1)
    {
      common_multiline=get_multiline(common_a,get_bgcolor(next_common));
      
      if (common_multiline != "")
        common_a[next_common]=common_multiline;

      next_maybe_common_multiline=0;
    }
    # Roles are often repeated, with one extra item per line.
    if ($1 == "role" && $3 == "types") role_a[$2]=get_cells_one_line(role_a[$2]);

    # Types never seem to be repeated, but they do have aliases.
    if ($1 == "type")
    {
      if (index($0,"#") > 0)
        $0=substr($0,1,index($0,"#"));
      attribs=split($0,type_line_a,",");
      aliases=split(type_line_a[1],type_alias_line_a);
      type=type_alias_line_a[2];
      if (attribs == 1)
      {
        type=substr(type,1,length(type)-1);
        type_a[type]="";
      }
      else
      {
        if (aliases == 4)
          alias=type_alias_line_a[4];
        else if (type_alias_line_a[aliases] == "}")
          alias=type_alias_line_a[aliases-1];
        
        for(i=2;i<attribs;i++)
        {
          type_a[type]=add_one_cell(type_a[type],type_line_a[i]);
        }
        type_a[type]=add_one_cell(type_a[type],substr(type_line_a[i],1,length(type_line_a[i])-1));
      }
      type_alias_a[type]=alias;
    }
    if ($1 == "type_transition")
    {
      # This section is buggy - it doesn't deal with multiple entries.
      # It's not at all clear that the basic represenation is appropriate.
      type_from=$2;
      type_to=substr($NF,1,length($NF)-1);
      type_from_a[type_from]=type_from;
      type_to_a[type_to]=type_to;
      $1=$2=$NF="";
      type_transition_a[type_from,type_to]=$0;
    }
    if ($1 == "class" && NF == 2)
    {
      next_class=$2;
      next_maybe_class_multiline=1;
    }
    if ($1 == "common" && NF == 2)
    {
      next_common=$2;
      next_maybe_common_multiline=1;
    }
  }
}
  
# ----------------------------------------
# End - actually display results
# ----------------------------------------
END {
  display_roles("policy_roles.html");
  display_commons("policy_commons.html");
  display_classes("policy_classes.html");
  display_types("policy_types.html");
  display_type_transitions("policy_transitions.html");
}

--------------292F2596F898F5ADA3B0DCCE--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
